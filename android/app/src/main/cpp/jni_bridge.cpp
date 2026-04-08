/**
 * @file jni_bridge.cpp
 * @brief JNI bridge for Android to freeciv-mobile-ffi
 */

#include <jni.h>
#include <memory>

// Include mobile FFI (created in mobile_ffi directory)
extern "C" {
    #include "../../../mobile_ffi/ffi_types.h"
    #include "../../../mobile_ffi/ffi_bridge.h"
}

// Thread-local storage for game instances (one per activity)
// In production, would be managed more carefully with proper lifecycle
static thread_local std::unique_ptr<ffi_game_t, void(*)(ffi_game_t*)> current_game(nullptr, ffi_destroy_game);

/**
 * Helper to convert Java string list to C string array
 */
static char** convertStringList(JNIEnv* env, jobjectArray stringArray, jsize* count) {
    if (!stringArray) return nullptr;
    
    jsize len = env->GetArrayLength(stringArray);
    if (len == 0) {
        *count = 0;
        return nullptr;
    }
    
    char** result = new char*[len];
    for (jsize i = 0; i < len; i++) {
        jstring jstr = (jstring)env->GetObjectArrayElement(stringArray, i);
        if (jstr) {
            const char* cstr = env->GetStringUTFChars(jstr, nullptr);
            result[i] = strdup(cstr);  // Caller (FFI) will free these
            env->ReleaseStringUTFChars(jstr, cstr);
            env->DeleteLocalRef(jstr);
        } else {
            result[i] = nullptr;
        }
    }
    *count = len;
    return result;
}

/**
 * Free string array allocated by convertStringList
 */
static void freeStringList(char** array, jsize count) {
    if (!array) return;
    for (jsize i = 0; i < count; i++) {
        free(array[i]);
    }
    delete[] array;
}

/**
 * JNI: Create a new game
 */
extern "C" JNIEXPORT jboolean JNICALL
Java_com_freeciv_mobile_engine_EngineBridge_nativeCreateGame(
    JNIEnv* env,
    jclass clazz,
    jobject settings) {
    (void)clazz;  // Unused
    
    // Extract fields from Java GameSettings object
    // Assuming it has getters: getMapSize(), getDifficulty(), etc.
    jclass settingsClass = env->GetObjectClass(settings);
    jmethodID getMapSize = env->GetMethodID(settingsClass, "getMapSize", "()I");
    jmethodID getDifficulty = env->GetMethodID(settingsClass, "getDifficulty", "()I");
    jmethodID getStartYear = env->GetMethodID(settingsClass, "getStartYear", "()I");
    jmethodID getMaxPlayers = env->GetMethodID(settingsClass, "getMaxPlayers", "()I");
    jmethodID getNations = env->GetMethodID(settingsClass, "getNations", "()Ljava/util/List;");
    
    jint mapSize = env->CallIntMethod(settings, getMapSize);
    jint difficulty = env->CallIntMethod(settings, getDifficulty);
    jint startYear = env->CallIntMethod(settings, getStartYear);
    jint maxPlayers = env->CallIntMethod(settings, getMaxPlayers);
    jobject nationsList = env->CallObjectMethod(settings, getNations);
    
    // Convert List to array
    jclass listClass = env->FindClass("java/util/List");
    jmethodID sizeMethod = env->GetMethodID(listClass, "size", "()I");
    jmethodID getMethod = env->GetMethodID(listClass, "get", "(I)Ljava/lang/Object;");
    jsize nationsCount = env->CallIntMethod(nationsList, sizeMethod);
    
    char** nationsArray = new char*[nationsCount];
    for (jsize i = 0; i < nationsCount; i++) {
        jstring nation = (jstring)env->CallObjectMethod(nationsList, getMethod, i);
        const char* cstr = env->GetStringUTFChars(nation, nullptr);
        nationsArray[i] = strdup(cstr);
        env->ReleaseStringUTFChars(nation, cstr);
        env->DeleteLocalRef(nation);
    }
    
    // Build FFI settings
    ffi_game_settings ffiSettings = {
        .map_size = static_cast<int32_t>(mapSize),
        .difficulty = static_cast<int32_t>(difficulty),
        .start_year = static_cast<int32_t>(startYear),
        .max_players = static_cast<int32_t>(maxPlayers),
        .nations_count = static_cast<int32_t>(nationsCount),
        .nations = const_cast<const char**>(nationsArray)
    };
    
    // Create game
    ffi_game_t* game = ffi_create_game(&ffiSettings);
    
    // Cleanup temporary arrays
    for (jsize i = 0; i < nationsCount; i++) {
        free(nationsArray[i]);
    }
    delete[] nationsArray;
    
    if (game) {
        // Store in thread-local
        current_game.reset(game);
        return JNI_TRUE;
    } else {
        return JNI_FALSE;
    }
}

/**
 * JNI: Execute an action
 */
extern "C" JNIEXPORT jint JNICALL
Java_com_freeciv_mobile_engine_EngineBridge_nativeDoAction(
    JNIEnv* env,
    jclass clazz,
    jlong gamePtr,  // Not used, we use thread-local
    jobject action) {
    (void)env;
    (void)clazz;
    (void)gamePtr;
    
    if (!current_game) {
        return -1;
    }
    
    // Extract fields from Java GameAction object
    jclass actionClass = env->GetObjectClass(action);
    jmethodID getActionType = env->GetMethodID(actionClass, "getActionType", "()I");
    jmethodID getUnitId = env->GetMethodID(actionClass, "getUnitId", "()I");
    jmethodID getTargetX = env->GetMethodID(actionClass, "getTargetX", "()I");
    jmethodID getTargetY = env->GetMethodID(actionClass, "getTargetY", "()I");
    jmethodID getTargetId = env->GetMethodID(actionClass, "getTargetId", "()I");
    
    ffi_action ffiAction = {
        .action_type = static_cast<int32_t>(env->CallIntMethod(action, getActionType)),
        .unit_id = static_cast<int32_t>(env->CallIntMethod(action, getUnitId)),
        .target_x = static_cast<int32_t>(env->CallIntMethod(action, getTargetX)),
        .target_y = static_cast<int32_t>(env->CallIntMethod(action, getTargetY)),
        .target_id = static_cast<int32_t>(env->CallIntMethod(action, getTargetId))
    };
    
    return ffi_do_action(current_game.get(), &ffiAction);
}

/**
 * JNI: Get game state
 */
extern "C" JNIEXPORT jobject JNICALL
Java_com_freeciv_mobile_engine_EngineBridge_nativeGetGameState(
    JNIEnv* env,
    jclass clazz,
    jlong gamePtr) {
    (void)clazz;
    (void)gamePtr;
    
    if (!current_game) {
        return nullptr;
    }
    
    ffi_game_state ffiState = ffi_get_game_state(current_game.get());
    
    // Construct Java GameState object
    // Find GameState class and its constructor
    jclass stateClass = env->FindClass("com/freeciv/mobile/engine/GameState");
    jmethodID constructor = env->GetMethodID(
        stateClass, 
        "<init>", 
        "(IIIII)V"
    );
    
    jobject stateObj = env->NewObject(
        stateClass,
        constructor,
        static_cast<jint>(ffiState.turn),
        static_cast<jint>(ffiState.year),
        static_cast<jint>(ffiState.player_count),
        static_cast<jint>(ffiState.units_count),
        static_cast<jint>(ffiState.cities_count)
    );
    
    return stateObj;
}

/**
 * JNI: Destroy game
 */
extern "C" JNIEXPORT void JNICALL
Java_com_freeciv_mobile_engine_EngineBridge_nativeDestroyGame(
    JNIEnv* env,
    jclass clazz,
    jlong gamePtr) {
    (void)env;
    (void)clazz;
    (void)gamePtr;
    
    current_game.reset(nullptr);
}
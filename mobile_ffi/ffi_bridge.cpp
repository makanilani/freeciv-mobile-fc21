/**
 * @file ffi_bridge.cpp
 * @brief Implementation of FFI bridge functions for mobile clients
 * 
 * This file provides the C-compatible interface that mobile clients (Swift/Kotlin)
 * use to interact with the Freeciv21 engine. It acts as a thin wrapper around
 * the engine's C++ API, managing game instances and translating data structures.
 */

#include "ffi_bridge.h"
#include "ffi_types.h"
#include "ffi_game.h"
#include "ffi_state.h"
#include "ffi_action.h"

#include <memory>
#include <mutex>
#include <cstring>

// Forward declarations from Freeciv21
struct game;
struct action;

// Opaque game handle implementation
struct ffi_game {
    std::unique_ptr<game> game_ptr;  // Owned game instance
    // Additional metadata can be added here
};

// Global registry for game instances (optional, for debugging)
static std::mutex g_game_registry_mutex;
static std::unordered_map<ffi_game_t*, uint64_t> g_game_registry;

// Simple counter for game IDs
static uint64_t g_next_game_id = 1;

/**
 * @brief Allocate a new ffi_game wrapper
 * @return Pointer to new ffi_game, or nullptr on allocation failure
 */
static ffi_game_t* ffi_game_create() {
    ffi_game_t* ffi_game = new (std::nothrow) ffi_game();
    if (!ffi_game) return nullptr;
    
    ffi_game->game_ptr = nullptr;
    
    // Register for debugging
    {
        std::lock_guard<std::mutex> lock(g_game_registry_mutex);
        g_game_registry[ffi_game] = g_next_game_id++;
    }
    
    return ffi_game;
}

/**
 * @brief Free an ffi_game wrapper
 * @param ffi_game Game wrapper to free
 */
static void ffi_game_destroy(ffi_game_t* ffi_game) {
    if (!ffi_game) return;
    
    // Unregister
    {
        std::lock_guard<std::mutex> lock(g_game_registry_mutex);
        g_game_registry.erase(ffi_game);
    }
    
    delete ffi_game;
}

// Public C API

extern "C" {

ffi_game_t* ffi_create_game(const ffi_game_settings* settings) {
    if (!settings) return nullptr;
    
    // Create wrapper
    ffi_game_t* ffi_game = ffi_game_create();
    if (!ffi_game) return nullptr;
    
    // Create actual game using ffi_game_create helper
    ffi_game->game_ptr = ffi_game_create_internal(settings);
    
    if (!ffi_game->game_ptr) {
        ffi_game_destroy(ffi_game);
        return nullptr;
    }
    
    return ffi_game;
}

void ffi_destroy_game(ffi_game_t* game) {
    if (!game) return;
    ffi_game_destroy(game);
}

int ffi_do_action(ffi_game_t* game, const ffi_action* action) {
    if (!game || !game->game_ptr || !action) {
        return -1; // Invalid parameters
    }
    
    return ffi_action_execute(game->game_ptr.get(), action);
}

ffi_game_state ffi_get_game_state(const ffi_game_t* game) {
    ffi_game_state state = {0, 0, 0, 0, 0};
    
    if (!game || !game->game_ptr) {
        return state;
    }
    
    return ffi_state_extract(game->game_ptr.get());
}

void ffi_free_game_state(ffi_game_state* state) {
    // Currently no dynamic allocation in ffi_game_state
    // This is a no-op but kept for API completeness
    (void)state;
}

bool ffi_end_turn(ffi_game_t* game) {
    if (!game || !game->game_ptr) {
        return false;
    }
    
    return ffi_action_end_turn(game->game_ptr.get()) == 0;
}

int ffi_get_player_units_count(const ffi_game_t* game, int player_id) {
    if (!game || !game->game_ptr) {
        return 0;
    }
    
    return ffi_state_get_player_units_count(game->game_ptr.get(), player_id);
}

int ffi_get_player_cities_count(const ffi_game_t* game, int player_id) {
    if (!game || !game->game_ptr) {
        return 0;
    }
    
    return ffi_state_get_player_cities_count(game->game_ptr.get(), player_id);
}

} // extern "C"
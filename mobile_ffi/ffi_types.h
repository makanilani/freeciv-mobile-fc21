/**
 * @file ffi_types.h
 * @brief C-compatible type definitions for mobile FFI
 * 
 * This header defines structures that can be safely passed across
 * language boundaries (Swift/JNI) using plain C types.
 */

#ifndef MOBILE_FFI_TYPES_H
#define MOBILE_FFI_TYPES_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/**
 * Game settings - initialized by mobile client, passed to engine
 */
typedef struct ffi_game_settings {
    int32_t map_size;
    int32_t difficulty;
    int32_t start_year;
    int32_t max_players;
    int32_t nations_count;
    const char** nations;  // Array of C strings (null-terminated)
} ffi_game_settings;

/**
 * Game action - represents a player action in the game
 */
typedef struct ffi_action {
    int32_t action_type;  // Action type enum (from common/actions.h)
    int32_t unit_id;      // Target unit ID (if applicable)
    int32_t target_x;     // Target tile X coordinate
    int32_t target_y;     // Target tile Y coordinate
    int32_t target_id;    // Target object ID (city, unit, etc.)
} ffi_action;

/**
 * Game state snapshot - read-only summary of current game state
 * This is a simplified view for mobile UI consumption.
 */
typedef struct ffi_game_state {
    int32_t turn;
    int32_t year;
    int32_t player_count;
    int32_t units_count;
    int32_t cities_count;
} ffi_game_state;

/**
 * Opaque game handle - mobile clients treat this as an opaque pointer
 */
typedef struct ffi_game ffi_game_t;

/**
 * Create a new game instance with the given settings.
 * 
 * @param[in] settings Game configuration
 * @return Pointer to game instance, or NULL on failure
 */
ffi_game_t* ffi_create_game(const ffi_game_settings* settings);

/**
 * Destroy a game instance and free all associated resources.
 * 
 * @param[in] game Game instance to destroy
 */
void ffi_destroy_game(ffi_game_t* game);

/**
 * Execute an action in the game.
 * 
 * @param[in] game Game instance
 * @param[in] action Action to execute
 * @return 0 on success, negative error code on failure
 */
int ffi_do_action(ffi_game_t* game, const ffi_action* action);

/**
 * Get a snapshot of the current game state.
 * This creates a copy of the state data that the caller owns.
 * 
 * @param[in] game Game instance
 * @return Game state snapshot (caller must free with ffi_free_game_state)
 */
ffi_game_state ffi_get_game_state(const ffi_game_t* game);

/**
 * Free a game state snapshot.
 * Only needed if we allocate dynamic memory in the state struct.
 * Currently the state is stack-allocated, so this is a no-op.
 * 
 * @param[in] state State to free
 */
void ffi_free_game_state(ffi_game_state* state);

/**
 * End the current turn.
 * Convenience function that sends an END_TURN action.
 * 
 * @param[in] game Game instance
 * @return true if turn ended successfully
 */
bool ffi_end_turn(ffi_game_t* game);

/**
 * Get the number of units for a player.
 * 
 * @param[in] game Game instance
 * @param[in] player_id Player index (0-based)
 * @return Number of units owned by player
 */
int ffi_get_player_units_count(const ffi_game_t* game, int player_id);

/**
 * Get the number of cities for a player.
 * 
 * @param[in] game Game instance
 * @param[in] player_id Player index (0-based)
 * @return Number of cities owned by player
 */
int ffi_get_player_cities_count(const ffi_game_t* game, int player_id);

#ifdef __cplusplus
}
#endif

#endif // MOBILE_FFI_TYPES_H
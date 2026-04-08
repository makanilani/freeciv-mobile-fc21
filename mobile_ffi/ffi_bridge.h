/**
 * @file ffi_bridge.h
 * @brief Internal bridge functions for FFI implementation
 * 
 * These functions implement the translation between mobile FFI types
 * and Freeciv21 engine types. They are NOT part of the public C API.
 */

#ifndef MOBILE_FFI_BRIDGE_H
#define MOBILE_FFI_BRIDGE_H

#include "ffi_types.h"
#include "../engine/common/game.h"  // From Freeciv21

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Internal function to create a game from settings
 * @param settings FFI settings struct
 * @return Unique ptr to game instance (C++), or nullptr on failure
 */
std::unique_ptr<::game> ffi_game_create_internal(const ffi_game_settings* settings);

/**
 * Internal function to execute an action
 * @param game_ptr Game instance (raw pointer)
 * @param action FFI action struct
 * @return 0 on success, negative error on failure
 */
int ffi_action_execute(::game* game_ptr, const ffi_action* action);

/**
 * Internal function to end turn
 * @param game_ptr Game instance
 * @return 0 on success
 */
int ffi_action_end_turn(::game* game_ptr);

/**
 * Internal function to extract game state snapshot
 * @param game_ptr Game instance
 * @return Filled ffi_game_state struct
 */
ffi_game_state ffi_state_extract(const ::game* game_ptr);

/**
 * Get units count for a player
 */
int ffi_state_get_player_units_count(const ::game* game_ptr, int player_id);

/**
 * Get cities count for a player
 */
int ffi_state_get_player_cities_count(const ::game* game_ptr, int player_id);

#ifdef __cplusplus
}
#endif

#endif // MOBILE_FFI_BRIDGE_H
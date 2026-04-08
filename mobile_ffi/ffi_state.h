/**
 * @file ffi_state.h
 * @brief Game state extraction utilities
 */

#ifndef MOBILE_FFI_STATE_H
#define MOBILE_FFI_STATE_H

#include "ffi_types.h"
#include "../engine/common/game.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Extract a simplified game state snapshot from the game instance
 */
ffi_game_state ffi_state_extract(const struct game* game_ptr);

/**
 * Get units count for a player
 */
int ffi_state_get_player_units_count(const struct game* game_ptr, int player_id);

/**
 * Get cities count for a player
 */
int ffi_state_get_player_cities_count(const struct game* game_ptr, int player_id);

#ifdef __cplusplus
}
#endif

#endif // MOBILE_FFI_STATE_H
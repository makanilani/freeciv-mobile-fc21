/**
 * @file ffi_action.h
 * @brief Action execution implementations
 */

#ifndef MOBILE_FFI_ACTION_H
#define MOBILE_FFI_ACTION_H

#include "ffi_types.h"
#include "../engine/common/game.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Execute a generic action on the game
 */
int ffi_action_execute(struct game* game_ptr, const ffi_action* action);

/**
 * End the current turn
 */
int ffi_action_end_turn(struct game* game_ptr);

/**
 * Map FFI action type to Freeciv21 action enums
 * (Defined in common/actions.h)
 */
#define FFI_ACTION_END_TURN 0
#define FFI_ACTION_MOVE 1
#define FFI_ACTION_ATTACK 2
#define FFI_ACTION_FORTIFY 3
#define FFI_ACTION_DISBAND 4
#define FFI_ACTION_BUILD 5
#define FFI_ACTION_BUILD_ROAD 6
#define FFI_ACTION_SETTLER_BUILD_CITY 7

#ifdef __cplusplus
}
#endif

#endif // MOBILE_FFI_ACTION_H
package com.freeciv.mobile.engine

/**
 * JNI Bridge for Freeciv Engine
 * Provides Kotlin interface to C++ game engine
 */
class EngineBridge {
    companion object {
        init {
            System.loadLibrary("freeciv-mobile")
        }
    }
    
    private external fun nativeCreateGame(settings: GameSettings): Long
    private external fun nativeDoAction(gamePtr: Long, action: GameAction): Int
    private external fun nativeGetGameState(gamePtr: Long): GameState?
    private external fun nativeDestroyGame(gamePtr: Long)
    
    private var gamePtr: Long = 0
    
    /**
     * Create a new game with the given settings
     */
    fun createGame(settings: GameSettings): Boolean {
        gamePtr = nativeCreateGame(settings)
        return gamePtr != 0L
    }
    
    /**
     * Execute a game action
     */
    fun doAction(action: GameAction): Int {
        if (gamePtr == 0L) return -1
        return nativeDoAction(gamePtr, action)
    }
    
    /**
     * Get current game state snapshot
     */
    fun getState(): GameState? {
        if (gamePtr == 0L) return null
        return nativeGetGameState(gamePtr)
    }
    
    /**
     * End the current turn
     */
    fun endTurn(): Boolean {
        val action = GameAction(
            actionType = 0, // ACTION_END_TURN
            unitId = 0,
            targetX = 0,
            targetY = 0,
            targetId = 0
        )
        return doAction(action) == 0
    }
    
    /**
     * Clean up game resources
     */
    fun destroy() {
        if (gamePtr != 0L) {
            nativeDestroyGame(gamePtr)
            gamePtr = 0L
        }
    }
}

/**
 * Data class representing game settings
 */
data class GameSettings(
    val mapSize: Int,
    val difficulty: Int,
    val startYear: Int,
    val maxPlayers: Int,
    val nations: List<String>
)

/**
 * Data class representing a game action
 */
data class GameAction(
    val actionType: Int,
    val unitId: Int,
    val targetX: Int,
    val targetY: Int,
    val targetId: Int
)

/**
 * Data class representing game state snapshot
 */
data class GameState(
    val turn: Int,
    val year: Int,
    val playerCount: Int,
    val unitsCount: Int,
    val citiesCount: Int
)
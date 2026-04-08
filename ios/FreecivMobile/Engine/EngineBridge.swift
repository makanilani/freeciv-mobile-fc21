import Foundation

// MARK: - C Types Interop

/// Game settings structure matching C++ GameSetup
struct GameSettings {
    let mapSize: Int32
    let difficulty: Int32
    let startYear: Int32
    let maxPlayers: Int32
    let nations: [String]
    
    func toC() -> fc_game_settings {
        return fc_game_settings(
            map_size: mapSize,
            difficulty: difficulty,
            start_year: startYear,
            max_players: maxPlayers,
            nations_count: Int32(nations.count),
            nations: nations.map { strdup($0) } // Simplified for demo
        )
    }
}

/// Action structure matching C++ action
struct GameAction {
    let actionType: Int32
    let unitId: Int32
    let targetX: Int32
    let targetY: Int32
    let targetId: Int32
    
    func toC() -> fc_action {
        return fc_action(
            action_type: actionType,
            unit_id: unitId,
            target_x: targetX,
            target_y: targetY,
            target_id: targetId
        )
    }
}

/// Game state structure (simplified)
struct GameState {
    let turn: Int32
    let year: Int32
    let playerCount: Int32
    let unitsCount: Int32
    let citiesCount: Int32
    
    init(fromC state: fc_game_state) {
        self.turn = state.turn
        self.year = state.year
        self.playerCount = state.player_count
        self.unitsCount = state.units_count
        self.citiesCount = state.cities_count
    }
}

// MARK: - C Function Declarations

@_silgen_name("fc_create_game")
func fcCreateGame(_ settings: UnsafePointer<fc_game_settings>) -> UnsafeMutableRawPointer?

@_silgen_name("fc_do_action")
func fcDoAction(_ game: UnsafeMutableRawPointer?, _ action: UnsafePointer<fc_action>) -> Int32

@_silgen_name("fc_get_game_state")
func fcGetGameState(_ game: UnsafeMutableRawPointer?) -> fc_game_state

@_silgen_name("fc_destroy_game")
func fcDestroyGame(_ game: UnsafeMutableRawPointer?)

// MARK: - Engine Bridge Class

class EngineBridge {
    private var game: UnsafeMutableRawPointer?
    
    init() {
        // Initialize with null game
        self.game = nil
    }
    
    deinit {
        if let gamePtr = game {
            fcDestroyGame(gamePtr)
        }
    }
    
    /// Create a new game with the given settings
    /// - Parameter settings: Game configuration
    /// - Returns: true if successful, false otherwise
    @discardableResult
    func createGame(settings: GameSettings) -> Bool {
        var cSettings = settings.toC()
        game = fcCreateGame(&cSettings)
        return game != nil
    }
    
    /// Execute a game action
    /// - Parameter action: The action to perform
    /// - Returns: ActionResult code (0 = success)
    @discardableResult
    func doAction(_ action: GameAction) -> Int32 {
        guard let gamePtr = game else {
            return -1 // Error: no game
        }
        var cAction = action.toC()
        return fcDoAction(gamePtr, &cAction)
    }
    
    /// Get current game state
    /// - Returns: GameState struct with current snapshot
    func getState() -> GameState? {
        guard let gamePtr = game else {
            return nil
        }
        let cState = fcGetGameState(gamePtr)
        return GameState(fromC: cState)
    }
    
    /// End the current turn
    /// - Returns: true if turn ended successfully
    @discardableResult
    func endTurn() -> Bool {
        let action = GameAction(
            actionType: 0, // ACTION_END_TURN
            unitId: 0,
            targetX: 0,
            targetY: 0,
            targetId: 0
        )
        return doAction(action) == 0
    }
}

// MARK: - C Struct Definitions

/// Corresponds to C++ fc::game_settings
struct fc_game_settings {
    let map_size: Int32
    let difficulty: Int32
    let start_year: Int32
    let max_players: Int32
    let nations_count: Int32
    let nations: UnsafePointer<UnsafePointer<CChar>?> // Array of C strings
}

/// Corresponds to C++ fc::action
struct fc_action {
    let action_type: Int32
    let unit_id: Int32
    let target_x: Int32
    let target_y: Int32
    let target_id: Int32
}

/// Corresponds to C++ fc::game_state (snapshot)
struct fc_game_state {
    let turn: Int32
    let year: Int32
    let player_count: Int32
    let units_count: Int32
    let cities_count: Int32
}
#!/bin/bash
# Freeciv Mobile - Teamwork Framework Initialization

set -e

echo "🔧 Initializing Freeciv Mobile Teamwork Framework..."

# 1. Create directory structure
echo "📁 Creating directory structure..."
mkdir -p teamwork/{knowledge,standups,tasks,decisions,standards}

# 2. Create initial documentation files
echo "📝 Creating documentation files..."

# Create task board
cat > teamwork/tasks.md << 'EOF'
# Freeciv Mobile - Team Task Board

## Current Sprint: [Sprint Number] - [Dates]

### To Do (Backlog)
- [ ] [Task Description] (Owner: [Agent])

### In Progress
- [ ] [Task Description] (Owner: [Agent])

### Done
- [x] [Task Description] (Owner: [Agent])

---

*Last Updated: [Date]*
EOF

# Create standup template
cat > teamwork/standup-template.md << 'EOF'
# Daily Standup Template

## [Date] - [Agent Name] Standup

### Yesterday's Progress
- **Task: [Task ID]** - [Task Description]
  - ✅ Completed: [What was accomplished]
  - ⚠️ Blocked: [Any blockers or dependencies]

### Today's Plan
- **Task: [Task ID]** - [What will be worked on]

### Blockers
- [ ] Blocker 1: [Description]
- [ ] Blocker 2: [Description]

---

*Standup complete: [Time]*
EOF

# Create decision record template
cat > teamwork/decision-record-template.md << 'EOF'
# Design Decision Record Template

## [Date] - [Decision Topic]

### Context
- **What is the problem?** 
- **What are the constraints?**

### Options Considered
#### **Option 1: [Description]**
- **Pros:** ...
- **Cons:** ...

### Decision
- **Chosen Option:** [Option X]
- **Rationale:** [Why]

---

*Last Updated: [Date]*
EOF

# 3. Create configuration files
echo "⚙️ Creating configuration files..."

# Create agent configuration
cat > teamwork/agent-config.yaml << 'EOF'
# Freeciv Mobile - AI Agent Configuration

agents:
  - name: project-lead
    role: Project Lead
    expertise: Architecture, C++, Rust, Systems Design
    working_dir: freeciv-mobile
    model: advanced
    provider: default
    
  - name: engine-architect
    role: Engine Architect
    expertise: C++, Game Algorithms, Data Structures
    working_dir: freeciv-mobile/engine
    model: advanced
    provider: default
    
  - name: mobile-ui
    role: Mobile UI Specialist
    expertise: Swift, Kotlin, Reactive Programming
    working_dir: freeciv-mobile/ios
    model: advanced
    provider: default
    
  - name: backend-multiplayer
    role: Backend Multiplayer Agent
    expertise: Rust, gRPC, WebSockets, Distributed Systems
    working_dir: freeciv-mobile/backend
    model: advanced
    provider: default
    
  - name: qa-integration
    role: QA & Integration Agent
    expertise: Testing, CI/CD, Documentation
    working_dir: freeciv-mobile
    model: advanced
    provider: default

sprint_duration: 7  # days per sprint
standup_time: "09:00"  # daily standup time
review_time: "15:00"   # daily review time
EOF

# 4. Create initial knowledge base
echo "📚 Creating knowledge base..."

# Create architecture diagram placeholder
cat > teamwork/knowledge/architecture/architecture-overview.md << 'EOF'
# Freeciv Mobile Architecture Overview

## High-Level Design

```
┌─────────────────────────────────────────────────────────────┐
│                      MOBILE APPS                             │
│  ┌─────────────────┐           ┌─────────────────┐          │
│  │   Android       │           │      iOS        │          │
│  │   (Kotlin)     │           │     (Swift)     │          │
│  └────────┬────────┘           └────────┬────────┘          │
└───────────┼──────────────────────────────┼──────────────────┘
            │                              │
┌───────────┴──────────────────────────────┴──────────────────┐
│                    PRESENTATION LAYER                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Map View   │  │   Controls  │  │   Dialogs    │     │
│  │  (OpenGL ES) │  │   (Touch)   │  │  (Bottom     │     │
│  │              │  │             │  │   Sheets)    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────┬───────────────────────────────────┘
                          │ Engine API (gRPC/REST)
┌─────────────────────────┴───────────────────────────────────┐
│                      ENGINE CORE                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Game Logic │  │   AI Core    │  │  Ruleset     │     │
│  │  (C++/Rust) │  │   (C++)     │  │   Loader     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Turn Mgmt  │  │  Pathfinding │  │   Network    │     │
│  │             │  │   (aicore)   │  │   Protocol   │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────────┐
│                      DATA LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   SQLite    │  │   Ruleset    │  │    Save      │     │
│  │  (offline)  │  │   (JSON)     │  │   Format     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Module Breakdown

### Engine Core Modules
1. **Game Logic**: Turn management, victory conditions
2. **Map**: Terrain, coordinates, fog of war
3. **Unit**: Unit creation, movement, combat
4. **City**: City management, production
5. **Player**: Diplomacy, statistics
6. **Tech**: Technology tree, research
7. **Combat**: Battle resolution
8. **Trade**: Trade routes, commerce
9. **Events**: Game events, notifications

### Presentation Layer
- **iOS**: SwiftUI with UIKit interop for OpenGL
- **Android**: Jetpack Compose with custom OpenGL view
- **Shared**: OpenGL ES 3.0 renderer, touch gesture system

### Data Layer
- **Local Storage**: SQLite for saves
- **Rulesets**: JSON format with schema validation
- **Network**: gRPC + Protocol Buffers

## API Contracts

### Core Services
```protobuf
service FreecivEngine {
  // Game lifecycle
  rpc CreateGame(CreateGameRequest) returns (GameState);
  rpc LoadGame(LoadGameRequest) returns (GameState);
  rpc SaveGame(SaveGameRequest) returns (SaveGameResponse);
  
  // Game actions
  rpc DoAction(Action) returns (ActionResult);
  rpc EndTurn(EndTurnRequest) returns (TurnResult);
  
  // Queries
  rpc GetState(GetStateRequest) returns (GameState);
  rpc GetValidActions(GetValidActionsRequest) returns (ValidActions);
}
```

## Standards & Conventions

### Coding Standards
- **C++**: C++17, RAII, smart pointers, modern practices
- **Rust**: Safe Rust, error handling with Result, concurrency
- **Swift**: SwiftUI, Combine, protocol-oriented programming
- **Kotlin**: Jetpack Compose, coroutines, flows

### API Design
- RESTful where possible
- gRPC for performance-critical operations
- Consistent error handling
- Versioned APIs

### Documentation
- All public APIs documented
- Design decisions recorded in DDRs
- Code comments for complex logic
- Regular updates to knowledge base

---

*This knowledge base is maintained by the team and updated regularly.*  
*Last Updated: [Date]*
EOF

# 5. Create standards documentation
cat > teamwork/standards/coding-standards.md << 'EOF'
# Freeciv Mobile - Coding Standards

## C++ Standards (Engine)

### Style Guide
- **Indentation**: 4 spaces, no tabs
- **Line Length**: Max 100 characters
- **Naming**: 
  - Types: PascalCase (e.g., `GameState`)
  - Functions: camelCase (e.g., `getTileType()`)
  - Variables: snake_case (e.g., `current_turn`)
  - Constants: UPPER_SNAKE_CASE (e.g., `MAX_PLAYERS`)
- **Braces**: K&R style (opening brace on same line)

### Modern C++ Practices
- **C++ Version**: C++17 minimum, C++20 preferred
- **Smart Pointers**: `std::unique_ptr` for exclusive ownership, `std::shared_ptr` for shared ownership
- **RAII**: Resource Acquisition Is Initialization pattern
- **Move Semantics**: Use move constructors/assignment operators
- **Range-based for**: Prefer over index-based loops
- **Const Correctness**: Use `const` extensively
- **Override/ final**: Always use `override` for virtual functions

### Safety
- **No Raw Pointers**: Use smart pointers or references
- **Bounds Checking**: Use container bounds checking
- **Error Handling**: Use exceptions for exceptional cases, error codes for expected errors
- **Resource Management**: Always release resources in destructors

### Performance
- **Pass by Reference**: Use `const&` for large objects
- **Avoid Unnecessary Copies**: Use move semantics
- **Cache-Friendly**: Prefer contiguous memory layouts
- **Algorithm Complexity**: Be aware of Big-O complexity

---

## Swift Standards (iOS)

### SwiftUI Guidelines
- **State Management**: Use `@State`, `@Binding`, `@ObservedObject` appropriately
- **View Composition**: Build small, reusable views
- **Modifiers**: Use view modifiers for styling
- **Environment**: Use environment objects for shared data
- **Navigation**: Use `NavigationView` and `NavigationLink`

### API Design
- **Protocol-Oriented**: Prefer protocols over base classes
- **Error Handling**: Use `throws` and `try/catch`
- **Optionals**: Use optional chaining and nil coalescing
- **Concurrency**: Use `async/await` and `Task`

---

## Kotlin Standards (Android)

### Jetpack Compose Guidelines
- **State Management**: Use `mutableStateOf`, `remember`, `derivedStateOf`
- **Composable Functions**: Stateless where possible, explicit dependencies
- **Recomposition**: Minimize work during recomposition
- **Navigation**: Use `NavController` or `BackStack`

### API Design
- **Coroutines**: Use `suspend` functions for async operations
- **Flows**: Use `Flow` for streams of data
- **Null Safety**: Leverage Kotlin's null safety features
- **Extension Functions**: Use for adding functionality to existing classes

---

## Rust Standards (Backend)

### Safety First
- **No Unsafe**: Avoid `unsafe` code unless absolutely necessary
- **Error Handling**: Use `Result<T, E>` and `?`
- **Ownership**: Follow Rust's ownership rules
- **Lifetimes**: Properly annotate lifetimes when needed

### Concurrency
- **Data Races**: Prevent by Rust's ownership system
- **Channels**: Use `std::sync::mpsc` or `crossbeam` for communication
- **Arc/Mutex**: Use `Arc<Mutex<T>>` for shared mutable state

### API Design
- **Traits**: Use traits for abstraction
- **Enums**: Use enums for type-safe unions
- **Pattern Matching**: Use `match` extensively
- **Error Messages**: Provide helpful error messages

---

## API Standards

### RESTful APIs
- **HTTP Methods**: Use correctly (GET, POST, PUT, DELETE)
- **Status Codes**: Use appropriate HTTP status codes
- **JSON Format**: Consistent structure, snake_case keys
- **Pagination**: Use cursor-based pagination for large datasets
- **Caching**: Use ETags and caching headers

### gRPC APIs
- **Protobuf Versioning**: Always bump version when changing APIs
- **Streaming**: Use streaming where appropriate
- **Error Handling**: Use `status` field with meaningful codes
- **Performance**: Design for efficiency

---

## Documentation Standards

### Code Comments
- **Functions**: Document purpose, parameters, return values
- **Complex Logic**: Explain non-obvious algorithms
- **Design Decisions**: Explain why something was done
- **TODOs**: Mark with `// TODO:` and include issue number

### API Documentation
- **Swagger/OpenAPI**: Provide API documentation
- **Examples**: Include usage examples
- **Error Codes**: Document all possible error responses
- **Rate Limits**: Document rate limiting

### Design Documents
- **Problem Statement**: Clearly define the problem
- **Options Considered**: List and evaluate alternatives
- **Decision**: Record the final decision
- **Impact**: Analyze impact on other systems

---

## Testing Standards

### Unit Tests
- **Coverage**: Aim for >80% coverage on core modules
- **Isolation**: Tests should be independent
- **Mocking**: Use mocks for external dependencies
- **Edge Cases**: Test boundary conditions
- **Error Cases**: Test error handling

### Integration Tests
- **Component Interaction**: Test how components work together
- **API Contracts**: Verify API contracts are honored
- **Database**: Test database interactions
- **External Services**: Test with real external services where possible

### Performance Tests
- **Benchmarks**: Regular performance benchmarks
- **Load Testing**: Test under expected load
- **Memory Usage**: Monitor memory consumption
- **Response Times**: Measure and optimize

---

## Git Standards

### Commit Messages
- **Format**: `<type>(<scope>): <subject>`
- **Types**: feat, fix, docs, style, refactor, test, chore
- **Scope**: Optional, module or component affected
- **Subject**: Short description (imperative mood)

### Branching
- **Main Branch**: `main` - always production-ready
- **Development Branch**: `dev` - integration branch
- **Feature Branches**: `feature/[agent]-[short-description]`
- **Release Branches**: `release/[version]`
- **Hotfix Branches**: `hotfix/[issue-number]`

### Pull Requests
- **Description**: Clear description of changes
- **Testing**: Instructions for testing
- **Reviewers**: At least one reviewer required
- **CI Checks**: All CI checks must pass

---

*This document is maintained by the team and updated as standards evolve.*  
*Last Updated: [Date]*
EOF

echo "✅ Teamwork framework initialized successfully!"
echo ""
echo "📋 Next Steps:"
echo "1. Review the framework documentation"
echo "2. Customize agent configurations"
echo "3. Start assigning tasks to agents"
echo "4. Begin daily standup meetings"
echo ""
echo "🚀 Framework ready for use!"

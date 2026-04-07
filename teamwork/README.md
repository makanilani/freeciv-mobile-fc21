# Freeciv Mobile - AI Agent Teamwork Framework

## Overview

This framework enables multiple AI agents to collaborate efficiently on the Freeciv Mobile project. It provides structured roles, task management, communication protocols, and progress tracking.

## Agent Roles

### Core Team Structure

#### 1. **Project Lead Agent (PLA)**
- **Primary Responsibility**: Overall project coordination and architecture
- **Expertise**: Systems design, C++, Rust, cross-platform development
- **Tools**: analyze, delegate, orchestrator, github
- **Session Name**: `project-lead`

#### 2. **Engine Architect Agent (EAA)**
- **Primary Responsibility**: Game engine extraction and core logic
- **Expertise**: C++, game algorithms, data structures, performance optimization
- **Tools**: analyze, delegate, developer, summarize
- **Session Name**: `engine-architect`

#### 3. **Mobile UI Specialist Agent (MUSA)**
- **Primary Responsibility**: Native UI implementation (SwiftUI/Jetpack Compose)
- **Expertise**: Swift, Kotlin, reactive programming, touch interfaces
- **Tools**: analyze, developer, apps, summarize
- **Session Name**: `mobile-ui`

#### 4. **Backend & Multiplayer Agent (BMA)**
- **Primary Responsibility**: Server infrastructure, networking, multiplayer sync
- **Expertise**: Rust, gRPC, WebSockets, distributed systems
- **Tools**: analyze, delegate, developer, summarize
- **Session Name**: `backend-multiplayer`

#### 5. **QA & Integration Agent (QAIA)**
- **Primary Responsibility**: Testing, integration, documentation
- **Expertise**: Testing frameworks, CI/CD, documentation, bug tracking
- **Tools**: analyze, developer, summarize, todo
- **Session Name**: `qa-integration`

## Task Management System

### Work Item Types

```markdown
- [ ] **FEATURE**: New functionality to implement
  - [ ] **UI**: Frontend implementation
  - [ ] **LOGIC**: Backend/business logic
  - [ ] **API**: Interface definitions
  - [ ] **TEST**: Test coverage

- [x] **BUG**: Defect to fix
- [ ] **REFACTOR**: Code structure improvement
- [ ] **OPTIMIZATION**: Performance enhancement
- [ ] **DOC**: Documentation update
```

### Task Assignment Protocol

1. **Task Creation**: Any agent can create a task using the standard format
2. **Task Claiming**: Agents claim tasks by updating the status to "in_progress"
3. **Parallel Work**: Multiple agents can work on different tasks simultaneously
4. **Dependency Management**: Agents must resolve dependencies before starting related tasks
5. **Handoff Procedure**: When switching agents, provide complete context

### Task Status Flow

```
CREATED → IN_PROGRESS → BLOCKED → REVIEW → COMPLETED
      ↳  READY_FOR_REVIEW ↱
```

## Communication Protocols

### Daily Standup Format

Each agent provides daily updates in `teamwork/standups/`:

```markdown
## [Date] - [Agent Name] Standup

### Yesterday's Progress
- Task: [Task ID] - [Description]
  - Completed: [What was done]
  - Blocked: [Any blockers]
- Task: [Task ID] - [Description]
  - Completed: [What was done]

### Today's Plan
- Task: [Task ID] - [What will be done]
- Task: [Task ID] - [What will be done]

### Blockers
- [List any blockers that need coordination]
```

### Design Decision Record (DDR)

When making architectural decisions:

```markdown
## [Date] - [Decision Topic]

### Context
- What is the problem?
- What are the constraints?

### Options Considered
1. **Option A**: [Description]
   - Pros: ...
   - Cons: ...
2. **Option B**: [Description]
   - Pros: ...
   - Cons: ...

### Decision
- **Chosen Option**: [Option X]
- **Rationale**: [Why this option]
- **Implications**: [What this affects]

### Stakeholders
- [Agent Names] - [Agreement Status]
```

## Knowledge Base Structure

```
teamwork/knowledge/
├── architecture/          # System architecture diagrams
├── api_contracts/         # API definitions and protobufs
├── code_samples/          # Reusable code patterns
├── decisions/             # Design decision records
├── research/              # Technical research findings
└── standards/             # Coding standards and best practices
```

## Progress Tracking

### Weekly Sprint Planning

Every Monday, agents review:

1. **Completed work** from previous week
2. **Blockers** that need resolution
3. **Priority tasks** for current week
4. **Resource allocation** (which agents on which tasks)

### Sprint Review Format

```markdown
## Sprint [Number] Review - [Date Range]

### Achievements
- **Features Completed**: [Count]
- **Bugs Fixed**: [Count]
- **Refactors**: [Count]
- **Tests Added**: [Count]

### Key Metrics
- **Code Coverage**: [X]%
- **Performance**: [Metrics]
- **Build Success Rate**: [X]%

### Blockers & Risks
- [List blockers with action items]
- [Risk mitigation strategies]

### Next Sprint Priorities
1. [Top priority]
2. [Second priority]
3. [Third priority]
```

### Handoff Checklist

When transitioning work between agents:

```markdown
## Work Handoff - [Task ID]

### Current Status
- **Progress**: [Percentage]
- **Completed**: [List completed items]
- **Remaining**: [List remaining items]

### Context & Decisions
- **Key Decisions Made**: [List with links to DDRs]
- **Design Documents**: [Links to diagrams/docs]
- **Known Issues**: [List known problems]

### Next Steps
1. [Immediate next action]
2. [Follow-up tasks]
3. [Dependencies to resolve]

### Contact Information
- **Current Agent**: [Name/Session]
- **Backup Agent**: [Name/Session]
- **Review Scheduled**: [Date]
```

## Tools & Integration

### Agent Session Management

```python
# Example session initialization pattern
def initialize_agent_session(agent_role, working_directory):
    """
    Initialize an agent session with appropriate context.
    
    Args:
        agent_role: The role of the agent (e.g., 'engine-architect')
        working_directory: The workspace directory for this agent
    """
    # Set up workspace context
    context(workspace_root=working_directory)
    
    # Load relevant documentation
    load_relevant_docs(agent_role)
    
    # Initialize task list
    initialize_task_list(agent_role)
    
    return session_id
```

### Parallel Work Strategy

```markdown
## Parallel Work Guidelines

### Safe Parallelization Zones
✅ **Can work in parallel**:
- Different modules (engine vs UI vs backend)
- Different layers (presentation vs logic vs data)
- Different features with no shared state
- Independent bug fixes

⚠️ **Use with caution**:
- Same module, different files
- API definitions (coordinate through API contracts)
- Refactoring that affects multiple agents

❌ **Must coordinate**:
- Shared data structures
- API contract changes
- Core architecture decisions
- Build system changes
```

## Getting Started

### First Week Setup

1. **Day 1**: Initialize all agent sessions and review documentation
2. **Day 2**: Complete codebase audit and create extraction priorities
3. **Day 3**: Set up CI/CD and create "Hello World" prototype
4. **Day 4**: Define first set of API contracts
5. **Day 5**: Hold first sprint planning and assign initial tasks

### Initial Task Board

```markdown
## Week 1 Task Board

### To Do
- [ ] Codebase audit complete (EAA)
- [ ] Engine skeleton created (EAA)
- [ ] CI/CD pipeline set up (QAIA)
- [ ] "Hello World" prototype (EAA + MUSA)
- [ ] API contract v0.1 (EAA + BMA)

### In Progress
- [ ] Documentation review (All agents)

### Done
- [x] Teamwork framework initialized
```

## Escalation Procedures

### When to Escalate

1. **Blockers** that prevent multiple agents from working
2. **Architectural disagreements** that can't be resolved
3. **Technical deadends** requiring redesign
4. **Performance issues** that threaten timelines

### Escalation Path

```
Agent → Team Lead → Project Lead → Stakeholders
    ↳ Technical Disagreement ↳ Schedule Impact ↳ Major Redesign
```

## Success Metrics

### Team Productivity

- **Features per sprint**: Target [X]
- **Bug rate**: < [X] per KLOC
- **Build success rate**: > 95%
- **Test coverage**: > 80% for core modules

### Code Quality

- **Static analysis**: No critical warnings
- **Code review**: 100% of changes reviewed
- **Documentation**: Up to date for all features

## Resources

### Documentation Links

- [Freeciv Mobile Architecture](docs/ARCHITECTURE.md)
- [MVP Scope](docs/SCOPE.md)
- [Technical Decisions](docs/DECISIONS.md)
- [Mobile UX Guidelines](docs/MOBILE_UX.md)

### Tool References

- [CMake Documentation](https://cmake.org/cmake/help/latest/)
- [gRPC Basics](https://grpc.io/docs/what-is-grpc/)
- [Rust vs C++ Comparison](research/rust-vs-cpp.md)

## Contact & Support

### Primary Contacts

- **Project Lead**: project-lead@freeciv-mobile.org
- **Technical Architect**: engine-architect@freeciv-mobile.org
- **UI/UX Lead**: mobile-ui@freeciv-mobile.org

### Emergency Support

For critical production issues:
- **P1**: Page all agents via @channel
- **P2**: Contact technical lead within 1 hour
- **P3**: Log in issue tracker

---

*Last Updated: [Current Date]*
*Next Review: [Next Week]*
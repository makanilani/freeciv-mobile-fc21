#!/bin/bash
# Freeciv Mobile - OpenCode Agent Launch Script
# Uses OpenRouter API with role-optimized free models
#
# Prerequisites:
#   - OpenCode CLI installed
#   - OPENROUTER_API_KEY environment variable set
#
# Usage:
#   ./teamwork/launch-opencode.sh              # List all agents
#   ./teamwork/launch-opencode.sh project-lead # Start specific agent
#   ./teamwork/launch-opencode.sh --all        # Show all agent commands

set -e

OPENROUTER_BASE_URL="https://openrouter.ai/api/v1"

# Check for OpenRouter API key
if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "⚠️  Warning: OPENROUTER_API_KEY environment variable not set"
    echo "   Please set it before running this script:"
    echo "   export OPENROUTER_API_KEY='your-api-key-here'"
    exit 1
fi

# Create necessary directories
mkdir -p teamwork/{knowledge/{architecture,api_contracts,code_samples,decisions,research,standards},standups,tasks,decisions}

# Agent model assignments (OpenRouter free tier, April 2026)
declare -A AGENT_MODELS
AGENT_MODELS[project-lead]="qwen/qwen3.6-plus:free"
AGENT_MODELS[engine-architect]="qwen/qwen3-coder:free"
AGENT_MODELS[mobile-ui]="qwen/qwen3.6-plus:free"
AGENT_MODELS[backend-multiplayer]="nvidia/nemotron-3-super-120b-a12b:free"
AGENT_MODELS[qa-integration]="stepfun/step-3.5-flash:free"

declare -A AGENT_ROLES
AGENT_ROLES[project-lead]="Project Lead (coordination & architecture)"
AGENT_ROLES[engine-architect]="Engine Architect (C++ game logic)"
AGENT_ROLES[mobile-ui]="Mobile UI (SwiftUI/Jetpack Compose)"
AGENT_ROLES[backend-multiplayer]="Backend & Multiplayer (WebSocket/CRDT)"
AGENT_ROLES[qa-integration]="QA & Integration (testing/CI-CD)"

echo "🚀 Freeciv Mobile AI Agent Team (OpenCode)"
echo ""
echo "📋 Agent Model Configuration:"
for agent in "${!AGENT_MODELS[@]}"; do
    echo "   ${AGENT_ROLES[$agent]}"
    echo "      Model: ${AGENT_MODELS[$agent]}"
done
echo ""

# Handle arguments
case "${1:-}" in
    --all)
        echo "📋 Commands to start each agent:"
        echo ""
        for agent in project-lead engine-architect mobile-ui backend-multiplayer qa-integration; do
            echo "   # ${AGENT_ROLES[$agent]}"
            echo "   opencode --agent $agent"
            echo ""
        done
        ;;
    project-lead|engine-architect|mobile-ui|backend-multiplayer|qa-integration)
        echo "▶️  Starting ${AGENT_ROLES[$1]}..."
        echo "   Model: ${AGENT_MODELS[$1]}"
        echo ""
        opencode --agent "$1"
        ;;
    --help|-h)
        echo "Usage:"
        echo "  $0                  # Show agent overview"
        echo "  $0 <agent-name>     # Start specific agent interactively"
        echo "  $0 --all            # Show commands for all agents"
        echo ""
        echo "Available agents:"
        for agent in project-lead engine-architect mobile-ui backend-multiplayer qa-integration; do
            echo "  $agent"
        done
        echo ""
        echo "Headless mode:"
        echo "  opencode run \"<prompt>\" --agent <agent-name>"
        ;;
    "")
        echo "💡 How to run agents:"
        echo ""
        echo "   Interactive TUI:"
        echo "   opencode --agent <agent-name>"
        echo ""
        echo "   Headless/scripted:"
        echo "   opencode run \"<prompt>\" --agent <agent-name>"
        echo ""
        echo "   Switch agents mid-session: Press Tab in TUI"
        echo ""
        echo "Available agents:"
        for agent in project-lead engine-architect mobile-ui backend-multiplayer qa-integration; do
            echo "   $agent - ${AGENT_ROLES[$agent]}"
        done
        echo ""
        echo "Run '$0 --all' for individual commands"
        echo "Run '$0 --help' for more options"
        ;;
    *)
        echo "❌ Unknown agent: $1"
        echo ""
        echo "Available agents:"
        for agent in project-lead engine-architect mobile-ui backend-multiplayer qa-integration; do
            echo "   $agent"
        done
        exit 1
        ;;
esac

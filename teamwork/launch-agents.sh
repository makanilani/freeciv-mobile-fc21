#!/bin/bash
# ⚠️  DEPRECATED — Use teamwork/launch-opencode.sh instead
#
# This Cline-based launcher is no longer supported.
# The OpenRouter models it references (nvidia/llama-3.1-nemotron-ultra-253b-v1:free,
# qwen/qwen3-32b:free) no longer exist and will fail at runtime.
#
# Migration: Run ./teamwork/launch-opencode.sh instead.
# Requires: OpenCode CLI + OPENROUTER_API_KEY env var.
#
# Freeciv Mobile - Agent Launch Script for Cline CLI
# Uses OpenRouter API with different model tiers per agent role

set -e

echo "🚀 Initializing Freeciv Mobile AI Agent Team (Cline CLI)..."

# Configuration
OPENROUTER_BASE_URL="https://openrouter.ai/api/v1"

# Check for OpenRouter API key
if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "Error: OPENROUTER_API_KEY environment variable is not set."
    echo "Please set it before running this script:"
    echo "export OPENROUTER_API_KEY='your-api-key-here'"
    exit 1
fi

# Create necessary directories
echo "📁 Creating directory structure..."
mkdir -p teamwork/{knowledge/{architecture,api_contracts,code_samples,decisions,research,standards},standups,tasks,decisions}

# Model assignments (OpenRouter)
PROJECT_LEAD_MODEL="nvidia/llama-3.1-nemotron-ultra-253b-v1:free"
ENGINE_ARCHITECT_MODEL="qwen/qwen3-32b:free"
MOBILE_UI_MODEL="qwen/qwen3-32b:free"
BACKEND_MODEL="qwen/qwen3-32b:free"
QA_MODEL="qwen/qwen3-32b:free"

echo ""
echo "👤 Agent Model Configuration:"
echo "   📋 Project Lead:        $PROJECT_LEAD_MODEL"
echo "   🔧 Engine Architect:    $ENGINE_ARCHITECT_MODEL"
echo "   📱 Mobile UI:           $MOBILE_UI_MODEL"
echo "   🌐 Backend/Multiplayer: $BACKEND_MODEL"
echo "   🧪 QA/Integration:      $QA_MODEL"
echo ""

# Generate agent-specific Cline configuration files
echo "⚙️  Generating agent configurations..."

# Project Lead Agent
cat > teamwork/.cline-project-lead.json << EOF
{
  "agent": {
    "name": "project-lead",
    "role": "Project Lead Agent",
    "model": "$PROJECT_LEAD_MODEL",
    "provider": "openrouter",
    "base_url": "$OPENROUTER_BASE_URL",
    "api_key": "$OPENROUTER_API_KEY"
  },
  "workspace": {
    "root": ".",
    "focus_areas": ["architecture", "coordination", "code-review"]
  }
}
EOF

# Engine Architect Agent
cat > teamwork/.cline-engine-architect.json << EOF
{
  "agent": {
    "name": "engine-architect",
    "role": "Engine Architect Agent",
    "model": "$ENGINE_ARCHITECT_MODEL",
    "provider": "openrouter",
    "base_url": "$OPENROUTER_BASE_URL",
    "api_key": "$OPENROUTER_API_KEY"
  },
  "workspace": {
    "root": "engine",
    "focus_areas": ["core-logic", "performance", "data-structures"]
  }
}
EOF

# Mobile UI Agent
cat > teamwork/.cline-mobile-ui.json << EOF
{
  "agent": {
    "name": "mobile-ui",
    "role": "Mobile UI Specialist Agent",
    "model": "$MOBILE_UI_MODEL",
    "provider": "openrouter",
    "base_url": "$OPENROUTER_BASE_URL",
    "api_key": "$OPENROUTER_API_KEY"
  },
  "workspace": {
    "root": "mobile",
    "focus_areas": ["ios", "android", "ui-ux"]
  }
}
EOF

# Backend/Multiplayer Agent
cat > teamwork/.cline-backend.json << EOF
{
  "agent": {
    "name": "backend-multiplayer",
    "role": "Backend & Multiplayer Agent",
    "model": "$BACKEND_MODEL",
    "provider": "openrouter",
    "base_url": "$OPENROUTER_BASE_URL",
    "api_key": "$OPENROUTER_API_KEY"
  },
  "workspace": {
    "root": "backend",
    "focus_areas": ["server", "networking", "multiplayer"]
  }
}
EOF

# QA/Integration Agent
cat > teamwork/.cline-qa.json << EOF
{
  "agent": {
    "name": "qa-integration",
    "role": "QA & Integration Agent",
    "model": "$QA_MODEL",
    "provider": "openrouter",
    "base_url": "$OPENROUTER_BASE_URL",
    "api_key": "$OPENROUTER_API_KEY"
  },
  "workspace": {
    "root": ".",
    "focus_areas": ["testing", "ci-cd", "documentation"]
  }
}
EOF

echo "✅ Agent configurations generated!"
echo ""
echo "📋 How to run individual agents:"
echo ""
echo "   # Project Lead (coordination & architecture)"
echo "   cline --config teamwork/.cline-project-lead.json"
echo ""
echo "   # Engine Architect (core game logic)"
echo "   cline --config teamwork/.cline-engine-architect.json"
echo ""
echo "   # Mobile UI Specialist"
echo "   cline --config teamwork/.cline-mobile-ui.json"
echo ""
echo "   # Backend & Multiplayer"
echo "   cline --config teamwork/.cline-backend.json"
echo ""
echo "   # QA & Integration"
echo "   cline --config teamwork/.cline-qa.json"
echo ""
echo "💡 Tip: Run agents in separate terminal windows or use tmux/screen"
echo ""
echo "🚀 Ready to collaborate!"
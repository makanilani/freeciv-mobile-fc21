#!/bin/bash
# Freeciv Mobile - Agent Launch Script

set -e

echo "🚀 Initializing Freeciv Mobile AI Agent Team..."

# Create necessary directories
mkdir -p teamwork/{knowledge,standups,tasks,decisions}

# Initialize agent sessions
echo "👤 Initializing Agent Sessions..."

# Project Lead Agent
echo "📋 Initializing Project Lead Agent..."
goose session --name "project-lead" --working-dir "freeciv-mobile" --model "your-model" --provider "your-provider" &

# Engine Architect Agent
echo "🔧 Initializing Engine Architect Agent..."
goose session --name "engine-architect" --working-dir "freeciv-mobile/engine" --model "your-model" --provider "your-provider" &

# Mobile UI Specialist Agent
echo "📱 Initializing Mobile UI Specialist Agent..."
goose session --name "mobile-ui" --working-dir "freeciv-mobile/ios" --model "your-model" --provider "your-provider" &

# Backend Multiplayer Agent
echo "🌐 Initializing Backend Multiplayer Agent..."
goose session --name "backend-multiplayer" --working-dir "freeciv-mobile/backend" --model "your-model" --provider "your-provider" &

# QA & Integration Agent
echo "🧪 Initializing QA & Integration Agent..."
goose session --name "qa-integration" --working-dir "freeciv-mobile" --model "your-model" --provider "your-provider" &

# Wait for all sessions to initialize
sleep 5

echo "✅ All agent sessions initialized!"
echo ""
echo "📋 Next Steps:"
echo "1. Review the teamwork framework documentation"
echo "2. Check the task board for assigned tasks"
echo "3. Join the daily standup meeting"
echo "4. Start collaborating on your assigned tasks"
echo ""
echo "📊 Team Status:"
goose orchestrator list_sessions

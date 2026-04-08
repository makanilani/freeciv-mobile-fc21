#!/bin/bash
# Freeciv Mobile - GitHub MCP Server Configuration
# This script sets up the GitHub MCP server for agent collaboration

# Check for required environment variables
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  Warning: GITHUB_TOKEN environment variable not set"
    echo "   Please set it before running this script:"
    echo "   export GITHUB_TOKEN='your-github-personal-access-token'"
    echo ""
    echo "You can generate a token at: https://github.com/settings/tokens"
    echo "Required scopes: repo, admin:org, admin:public_key, admin:repo_hook"
    exit 1
fi

# Create GitHub MCP server configuration directory
mkdir -p teamwork/mcp-servers/github

# Create the GitHub MCP server configuration file
cat > teamwork/mcp-servers/github/config.yaml << EOF
# GitHub MCP Server Configuration
# Enables agents to interact with GitHub repositories

server:
  name: "github-mcp"
  version: "1.0.0"
  
# GitHub API configuration
github:
  token: "$GITHUB_TOKEN"
  base_url: "https://api.github.com"
  graphql_url: "https://api.github.com/graphql"
  
# Supported tools
tools:
  - name: "github_create_repo"
    description: "Create a new GitHub repository"
    inputSchema:
      type: object
      properties:
        name:
          type: string
          description: Repository name
        description:
          type: string
          description: Repository description (optional)
        private:
          type: boolean
          description: Whether the repo should be private (optional, default: false)
          
  - name: "github_clone_repo"
    description: "Clone a GitHub repository"
    inputSchema:
      type: object
      properties:
        url:
          type: string
          description: Repository clone URL
        directory:
          type: string
          description: Local directory to clone into (optional)
          
  - name: "github_create_issue"
    description: "Create a new GitHub issue"
    inputSchema:
      type: object
      properties:
        repo:
          type: string
          description: Repository path (e.g., "owner/repo")
        title:
          type: string
          description: Issue title
        body:
          type: string
          description: Issue description/body (optional)
        assignees:
          type: array
          items:
            type: string
          description: Usernames to assign to the issue (optional)
        labels:
          type: array
          items:
            type: string
          description: Label names to apply (optional)
          
  - name: "github_search_issues"
    description: "Search GitHub issues"
    inputSchema:
      type: object
      properties:
        repo:
          type: string
          description: Repository path (e.g., "owner/repo")
        query:
          type: string
          description: Search query
        limit:
          type: number
          description: Maximum number of results (optional, default: 10)
          
  - name: "github_list_repos"
    description: "List user's repositories"
    inputSchema:
      type: object
      properties:
        type:
          type: string
          enum: ["all", "public", "private", "sources", "forks", "archived", "mirrors"]
          description: Repository type filter (optional, default: "all")
        sort:
          type: string
          enum: ["created", "updated", "pushed", "full_name"]
          description: Sort field (optional, default: "full_name")
        limit:
          type: number
          description: Maximum number of results (optional, default: 20)
          
  - name: "github_create_pr"
    description: "Create a GitHub pull request"
    inputSchema:
      type: object
      properties:
        repo:
          type: string
          description: Repository path (e.g., "owner/repo")
        title:
          type: string
          description: PR title
        head:
          type: string
          description: Source branch (e.g., "branch-name")
        base:
          type: string
          description: Target branch (e.g., "main")
        body:
          type: string
          description: PR description/body (optional)
          
  - name: "github_comment_on_issue"
    description: "Comment on a GitHub issue"
    inputSchema:
      type: object
      properties:
        repo:
          type: string
          description: Repository path (e.g., "owner/repo")
        issue_number:
          type: number
          description: Issue number
        body:
          type: string
          description: Comment body
EOF

echo "✅ GitHub MCP server configuration created!"
echo ""
echo "📋 Configuration location: teamwork/mcp-servers/github/config.yaml"
echo ""
echo "🔧 Setup complete. To use the GitHub MCP server:"
echo "   1. Set your GitHub token: export GITHUB_TOKEN='your-token-here'"
echo "   2. Start an agent with: opencode --agent <agent-name>"
echo "   3. The agents can now use GitHub tools like github_create_issue, github_create_pr, etc."
echo ""
echo "💡 Tip: Add GITHUB_TOKEN to your ~/.bashrc or ~/.zshrc for persistence"

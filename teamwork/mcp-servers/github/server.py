#!/usr/bin/env python3
"""
GitHub MCP Server Implementation
Provides GitHub integration for Freeciv Mobile AI agents
"""

import os
import json
from typing import Dict, Any, List, Optional
from datetime import datetime

from mcp import Server, Tool, ListTools
from mcp.server.models import CompletionResponse
from mcp.server.stdio import StdioServer
import requests


class GitHubMCPServer:
    def __init__(self):
        self.github_token = os.environ.get("GITHUB_TOKEN")
        self.github_base_url = "https://api.github.com"

        if not self.github_token:
            print("⚠️  Warning: GITHUB_TOKEN environment variable not set")
            print("   GitHub tools will be unavailable")

    def _github_headers(self) -> Dict[str, str]:
        """Get headers for GitHub API requests"""
        headers = {
            "Authorization": f"token {self.github_token}",
            "Accept": "application/vnd.github.v3+json",
            "Content-Type": "application/json",
        }
        return headers

    def _github_get(self, endpoint: str) -> Dict[str, Any]:
        """Send GET request to GitHub API"""
        url = f"{self.github_base_url}{endpoint}"
        response = requests.get(url, headers=self._github_headers())
        response.raise_for_status()
        return response.json()

    def _github_post(self, endpoint: str, data: Dict[str, Any]) -> Dict[str, Any]:
        """Send POST request to GitHub API"""
        url = f"{self.github_base_url}{endpoint}"
        response = requests.post(url, headers=self._github_headers(), json=data)
        response.raise_for_status()
        return response.json()

    def _github_patch(self, endpoint: str, data: Dict[str, Any]) -> Dict[str, Any]:
        """Send PATCH request to GitHub API"""
        url = f"{self.github_base_url}{endpoint}"
        response = requests.patch(url, headers=self._github_headers(), json=data)
        response.raise_for_status()
        return response.json()

    def _github_delete(self, endpoint: str) -> None:
        """Send DELETE request to GitHub API"""
        url = f"{self.github_base_url}{endpoint}"
        response = requests.delete(url, headers=self._github_headers())
        response.raise_for_status()

    def list_tools(self) -> List[Tool]:
        """List all available tools"""
        return [
            Tool(
                name="github_create_repo",
                description="Create a new GitHub repository",
                input_schema={
                    "type": "object",
                    "properties": {
                        "name": {"type": "string", "description": "Repository name"},
                        "description": {
                            "type": "string",
                            "description": "Repository description (optional)",
                        },
                        "private": {
                            "type": "boolean",
                            "description": "Whether the repo should be private (optional, default: false)",
                        },
                    },
                },
            ),
            Tool(
                name="github_clone_repo",
                description="Clone a GitHub repository",
                input_schema={
                    "type": "object",
                    "properties": {
                        "url": {
                            "type": "string",
                            "description": "Repository clone URL",
                        },
                        "directory": {
                            "type": "string",
                            "description": "Local directory to clone into (optional)",
                        },
                    },
                },
            ),
            Tool(
                name="github_create_issue",
                description="Create a new GitHub issue",
                input_schema={
                    "type": "object",
                    "properties": {
                        "repo": {
                            "type": "string",
                            "description": 'Repository path (e.g., "owner/repo")',
                        },
                        "title": {"type": "string", "description": "Issue title"},
                        "body": {
                            "type": "string",
                            "description": "Issue description/body (optional)",
                        },
                        "assignees": {
                            "type": "array",
                            "items": {"type": "string"},
                            "description": "Usernames to assign to the issue (optional)",
                        },
                        "labels": {
                            "type": "array",
                            "items": {"type": "string"},
                            "description": "Label names to apply (optional)",
                        },
                    },
                },
            ),
            Tool(
                name="github_search_issues",
                description="Search GitHub issues",
                input_schema={
                    "type": "object",
                    "properties": {
                        "repo": {
                            "type": "string",
                            "description": 'Repository path (e.g., "owner/repo")',
                        },
                        "query": {"type": "string", "description": "Search query"},
                        "limit": {
                            "type": "number",
                            "description": "Maximum number of results (optional, default: 10)",
                        },
                    },
                },
            ),
            Tool(
                name="github_list_repos",
                description="List user's repositories",
                input_schema={
                    "type": "object",
                    "properties": {
                        "type": {
                            "type": "string",
                            "enum": [
                                "all",
                                "public",
                                "private",
                                "sources",
                                "forks",
                                "archived",
                                "mirrors",
                            ],
                            "description": 'Repository type filter (optional, default: "all")',
                        },
                        "sort": {
                            "type": "string",
                            "enum": ["created", "updated", "pushed", "full_name"],
                            "description": 'Sort field (optional, default: "full_name")',
                        },
                        "limit": {
                            "type": "number",
                            "description": "Maximum number of results (optional, default: 20)",
                        },
                    },
                },
            ),
            Tool(
                name="github_create_pr",
                description="Create a GitHub pull request",
                input_schema={
                    "type": "object",
                    "properties": {
                        "repo": {
                            "type": "string",
                            "description": 'Repository path (e.g., "owner/repo")',
                        },
                        "title": {"type": "string", "description": "PR title"},
                        "head": {
                            "type": "string",
                            "description": 'Source branch (e.g., "branch-name")',
                        },
                        "base": {
                            "type": "string",
                            "description": 'Target branch (e.g., "main")',
                        },
                        "body": {
                            "type": "string",
                            "description": "PR description/body (optional)",
                        },
                    },
                },
            ),
            Tool(
                name="github_comment_on_issue",
                description="Comment on a GitHub issue",
                input_schema={
                    "type": "object",
                    "properties": {
                        "repo": {
                            "type": "string",
                            "description": 'Repository path (e.g., "owner/repo")',
                        },
                        "issue_number": {
                            "type": "number",
                            "description": "Issue number",
                        },
                        "body": {"type": "string", "description": "Comment body"},
                    },
                },
            ),
        ]

    @ListTools
    def handle_list_tools(self) -> List[Tool]:
        return self.list_tools()

    def handle_github_create_repo(
        self, name: str, description: Optional[str] = None, private: bool = False
    ) -> CompletionResponse:
        """Create a new GitHub repository"""
        if not self.github_token:
            return CompletionResponse(
                content=f"Error: GITHUB_TOKEN environment variable not set"
            )

        data = {"name": name, "description": description, "private": private}

        try:
            result = self._github_post("/user/repos", data)
            return CompletionResponse(
                content=f"✅ Successfully created repository: {result['html_url']}\n\nName: {result['name']}\nDescription: {result.get('description', 'None')}\nURL: {result['html_url']}\nPrivate: {result['private']}"
            )
        except Exception as e:
            return CompletionResponse(content=f"❌ Error creating repository: {str(e)}")

    def handle_github_clone_repo(
        self, url: str, directory: Optional[str] = None
    ) -> CompletionResponse:
        """Clone a GitHub repository"""
        # This would be executed by the agent, just return instructions
        dir_part = directory if directory else os.path.basename(url).replace(".git", "")
        return CompletionResponse(
            content=f"🔧 To clone the repository, run:\n\ngit clone {url} {dir_part}\n\nThis will create a local copy of the repository in the '{dir_part}' directory."
        )

    def handle_github_create_issue(
        self,
        repo: str,
        title: str,
        body: Optional[str] = None,
        assignees: Optional[List[str]] = None,
        labels: Optional[List[str]] = None,
    ) -> CompletionResponse:
        """Create a new GitHub issue"""
        if not self.github_token:
            return CompletionResponse(
                content=f"Error: GITHUB_TOKEN environment variable not set"
            )

        data = {"title": title, "body": body, "assignees": assignees, "labels": labels}

        try:
            result = self._github_post(f"/repos/{repo}/issues", data)
            return CompletionResponse(
                content=f"✅ Successfully created issue: {result['html_url']}\n\nTitle: {result['title']}\nNumber: {result['number']}\nURL: {result['html_url']}"
            )
        except Exception as e:
            return CompletionResponse(content=f"❌ Error creating issue: {str(e)}")

    def handle_github_search_issues(
        self, repo: str, query: str, limit: int = 10
    ) -> CompletionResponse:
        """Search GitHub issues"""
        try:
            # GitHub search API: /search/issues?q=repo:{repo}+{query}
            search_query = f"repo:{repo}+{query}"
            result = self._github_get(
                f"/search/issues?q={search_query}&per_page={limit}"
            )

            if result.get("total_count", 0) == 0:
                return CompletionResponse(
                    content=f"🔍 No issues found for query: {query}"
                )

            issues = result.get("items", [])
            output = f"🔍 Found {len(issues)} issues:\n\n"
            for i, issue in enumerate(issues[:limit]):
                output += f"{i + 1}. [{issue['title']}]({issue['html_url']}) - {issue['state']}\n"
                output += f"   Number: {issue['number']} | User: @{issue['user']['login']}\n\n"

            return CompletionResponse(content=output)
        except Exception as e:
            return CompletionResponse(content=f"❌ Error searching issues: {str(e)}")

    def handle_github_list_repos(
        self, type: str = "all", sort: str = "full_name", limit: int = 20
    ) -> CompletionResponse:
        """List user's repositories"""
        if not self.github_token:
            return CompletionResponse(
                content=f"Error: GITHUB_TOKEN environment variable not set"
            )

        try:
            result = self._github_get(
                f"/user/repos?type={type}&sort={sort}&per_page={limit}"
            )

            output = f"📁 Your repositories ({len(result)} found):\n\n"
            for repo in result:
                output += f"• {repo['name']}"
                if repo["description"]:
                    output += f": {repo['description']}"
                output += f" - {repo['html_url']}\n"
                output += f"  Stars: {repo['stargazers_count']} | Forks: {repo['forks_count']} | Private: {repo['private']}\n\n"

            return CompletionResponse(content=output)
        except Exception as e:
            return CompletionResponse(
                content=f"❌ Error listing repositories: {str(e)}"
            )

    def handle_github_create_pr(
        self, repo: str, title: str, head: str, base: str, body: Optional[str] = None
    ) -> CompletionResponse:
        """Create a GitHub pull request"""
        if not self.github_token:
            return CompletionResponse(
                content=f"Error: GITHUB_TOKEN environment variable not set"
            )

        data = {"title": title, "head": head, "base": base, "body": body}

        try:
            result = self._github_post(f"/repos/{repo}/pulls", data)
            return CompletionResponse(
                content=f"✅ Successfully created pull request: {result['html_url']}\n\nTitle: {result['title']}\nNumber: {result['number']}\nURL: {result['html_url']}"
            )
        except Exception as e:
            return CompletionResponse(
                content=f"❌ Error creating pull request: {str(e)}"
            )

    def handle_github_comment_on_issue(
        self, repo: str, issue_number: int, body: str
    ) -> CompletionResponse:
        """Comment on a GitHub issue"""
        if not self.github_token:
            return CompletionResponse(
                content=f"Error: GITHUB_TOKEN environment variable not set"
            )

        try:
            result = self._github_post(
                f"/repos/{repo}/issues/{issue_number}/comments", {"body": body}
            )
            return CompletionResponse(
                content=f"✅ Successfully commented on issue #{issue_number}\n\nComment URL: {result['html_url']}"
            )
        except Exception as e:
            return CompletionResponse(content=f"❌ Error commenting on issue: {str(e)}")

    def run(self):
        """Run the MCP server"""
        server = Server(
            [StdioServer()],
            self.handle_list_tools,
            {
                "github_create_repo": self.handle_github_create_repo,
                "github_clone_repo": self.handle_github_clone_repo,
                "github_create_issue": self.handle_github_create_issue,
                "github_search_issues": self.handle_github_search_issues,
                "github_list_repos": self.handle_github_list_repos,
                "github_create_pr": self.handle_github_create_pr,
                "github_comment_on_issue": self.handle_github_comment_on_issue,
            },
        )
        server.run()


if __name__ == "__main__":
    server = GitHubMCPServer()
    server.run()

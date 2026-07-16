# Git workflow
## Before committing
Apply these steps before any commit:
1. Check your changes for unnecessary complexity, redundant code, and unclear naming
2. Run build and tests covering changed code
3. Run linters and type checkers and fix issues

## Commits
- Do not commit code automatically unless explicitly instructed by user
- Warn before pushing to `master`/`main` and require explicit confirmation

## Commit messages
- Use imperative mood (e.g. `Add new feature`)
- Leave empty commit body unless explicitly instructed by user
- If work is related to Jira ticket, prefix commit message with ticket ID (e.g. `PROJ-123 Change image size`)

## Working trees
When implementing changes in a Git repository, set up an isolated workspace to enable parallel execution:
- Use `git worktree add <path> -b <branch> <base-branch>` to create an isolated worktree (do NOT use `EnterWorktree` — it does not work in subagents)
- Always place worktrees under `.claude/worktrees/` in the repo root — never use `/tmp`
- Use `git -C <path>` to run git commands inside the worktree without `cd`
- Worktrees allow multiple independent tasks to run in parallel without interfering with each other

## Merge Requests
- Always use `git make-mr` or `git make-draft-mr` to create merge requests — never use GitLab MCP tools for this

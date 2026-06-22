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
When implementing changes in a Git repository, follow the `using-git-worktrees` skill to set up an isolated workspace.

## Aliases
| Task                                     | Command             |
| ---------------------------------------- | ------------------- |
| View commits only made by user           | `git my-commits`    |
| Create Merge Request (GitLab only)       | `git make-mr`       |
| Create draft Merge Request (GitLab only) | `git make-draft-mr` |

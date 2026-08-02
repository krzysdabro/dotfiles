# Git workflow

1. **Isolate** — create a worktree under `.claude/worktrees/` before implementing changes
2. **Verify** — review the diff, then run build, tests, linters and type checkers
3. **Commit** — only when explicitly instructed, with an imperative message and empty body
4. **Integrate** — push (never to `master`/`main` without confirmation) and open an MR with `git make-mr`

## Worktrees
When implementing changes in a Git repository, set up an isolated workspace to enable parallel execution:
- Use `git worktree add <path> -b <branch> <base-branch>` to create an isolated worktree (do NOT use `EnterWorktree` — it does not work in subagents)
- Always place worktrees under `.claude/worktrees/` in the repo root — never use `/tmp`
- Use `git -C <path>` to run git commands inside the worktree without `cd`
- Worktrees allow multiple independent tasks to run in parallel without interfering with each other

## Before committing
Apply these steps before any commit:
1. Check your changes for unnecessary complexity, redundant code, and unclear naming
2. Run build and tests covering changed code
3. Run linters and type checkers and fix issues

## Commits
- Do not commit code automatically unless explicitly instructed by user
- Warn before pushing to default branch (usually `master`, `main` or `develop`) and require explicit confirmation

## Commit messages
- Use imperative mood (e.g. `Add new feature`)
- Leave empty commit body unless explicitly instructed by user
- If work is related to Jira ticket, prefix commit message with ticket ID (e.g. `PROJ-123 Change image size`)

## Merging changes
- Always use `git make-mr` or `git make-draft-mr` to create merge requests — never use GitLab MCP tools for this
- Squash merge to keep history clean and linear — one commit per MR makes features easy to revert and simplifies `git bisect`
- Keep merge requests small — it reduces merge conflict risk, are easier to review, and pair well with squash merging for clean reverts
- Tell the user when a merge request is growing large or spans unrelated concerns, and suggest splitting it into stacked MRs. A large MR is fine as an exception (bulk renames, migrations), but never as the default

### Stacked merge requests
A stacked MR is branched off another MR, so it contains the commits of the one below it. When fixing an issue in a lower MR:
1. Commit the fix as a fixup onto the commit it belongs to: `git fix <sha>`
2. Rebase to apply the fixup and move every stacked branch ref at once: `git rebase <base-branch>` (`autoSquash` and `updateRefs` are enabled in the global config)
3. Force-push each affected branch with `git fpush`

Never apply the fix directly on the upper branch — it belongs to the lower MR and the stack will conflict on merge.

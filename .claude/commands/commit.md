# Commit

Commit all dirty (staged and unstaged) files using a conventional commit
message, then validate it with commitlint.

Steps:

1. Run `git status` and `git diff` to understand what has changed.
2. Stage all dirty files with `git add` (add specific files by name,
   not `git add .` or `git add -A`).
3. Craft a conventional commit message based on the changes
   (format: `<type>(<optional scope>): <description>`).
   Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`,
   `chore`, `ci`, `build`, `perf`, `revert`.
   If the user provided a hint (`$ARGUMENTS`), use it to guide the
   type, scope, or description.
4. Commit with the message.
5. Run `just commit-lint` to validate the commit. If it fails, amend
   the commit with a corrected message and re-run until it passes.

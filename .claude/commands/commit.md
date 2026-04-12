# Commit

Commit staged and unstaged changes using a **conventional commit** message,
then validate with commitlint.

All commits must follow [Conventional Commits](https://www.conventionalcommits.org/)
specification and pass `just commit-lint` validation.

## Steps

1. **Understand the changes**: Run `git status` and `git diff HEAD` to see what files and code have changed.

2. **Decide on grouping**: If multiple files are dirty, determine whether they should be one commit or several:
   - One logical change (same feature, same bug, same refactor) → one commit
   - Different concerns (e.g., config update + new script) → separate commits
   - When in doubt, split — smaller commits are easier to review and revert

3. **Stage files**: Run `git add` with specific file names (never `git add .` or `git add -A`).
   - Stage only files for the current commit
   - Unrelated changes stay dirty for the next commit

4. **Write the commit message**:
   - Format: `<type>(<scope>): <description>`
   - Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `build`, `perf`, `revert`
   - Scope (optional): the module/component affected
   - Description: clear, lowercase, imperative mood ("add" not "added")
   - If the user provided a hint (e.g., `/commit fix(auth): ...`), use it to guide type and scope

5. **Commit**: Create the commit with your message.

6. **Validate**: Run `just commit-lint` to validate the message format.
   If it fails, amend with: `git commit --amend`, fix the message, and re-run validation.

repo_dir := justfile_directory()

# Check commits against conventional commit specification
# Usage: just commitlint [from]
# Example: just commitlint origin/main
commitlint from="HEAD~1":
    docker run --rm \
        --user $(id --user):$(id --group) \
        --volume {{repo_dir}}:/repo \
        --workdir /repo \
        commitlint/commitlint \
        --from={{from}} \
        --to=HEAD \
        --verbose

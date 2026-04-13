function wt
    set -l branch $argv[1]
    if test -z "$branch"
        echo "Usage: wt <branch>" >&2
        return 1
    end

    set -l git_common (git rev-parse --git-common-dir 2>/dev/null)
    or begin
        echo "Not in a git repo" >&2
        return 1
    end

    set -l wt_path "$git_common/worktrees/$branch"

    set -l existing (git worktree list --porcelain \
        | awk '/^worktree /{p=substr($0,10)} /^branch refs\/heads\//{b=substr($0,19)} /^$/{if(b==B)print p; b=""}  END{if(b==B)print p}' \
              B="$branch")

    if test -n "$existing"
        cd "$existing"; or return 1
        return
    end

    if git show-ref --verify --quiet "refs/heads/$branch"
        git worktree add "$wt_path" "$branch"
    else
        git worktree add -b "$branch" "$wt_path"
    end; or return 1

    cd "$wt_path"; or return 1
end

function wtl
    set -l dir (git worktree list | fzf --height=~100% | awk '{print $1}')
    or return 1
    test -n "$dir"; or return 1
    cd "$dir"; or return 1
end

function wtr
    set -l git_common (git rev-parse --git-common-dir 2>/dev/null)
    or begin
        echo "Not in a git repo" >&2
        return 1
    end
    cd "$git_common/.."; or return 1
end

function fish_prompt
  set -l git_branch (git symbolic-ref HEAD 2>/dev/null | sed 's|refs/heads/||')
  set -l git_status (git status --porcelain 2>/dev/null)

  # Directory name (cyan, last component only)
  set_color -o cyan
  echo -n (basename (prompt_pwd))
  set_color normal

  # Git status
  if test -n "$git_branch"
    if test -z "$git_status"
      # Clean repository (green)
      echo -n " on "
      set_color -o green
      echo -n "$git_branch"
      set_color normal
    else
      # Dirty repository (red)
      echo -n " on "
      set_color -o red
      echo -n "$git_branch"
      set_color normal
    end

    # Check for unpushed commits
    set -l unpushed (git cherry -v origin/$git_branch 2>/dev/null)
    if test -n "$unpushed"
      echo -n " with "
      set_color -o magenta
      echo -n "unpushed"
      set_color normal
    end
  end

  echo
  echo -n "› "
end

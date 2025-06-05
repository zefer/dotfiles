alias git hub

# Basic git commands
abbr gl "git pull"
abbr gp "git push origin HEAD"
abbr gd "git diff"
abbr gc "git commit"
abbr gca "git commit -a"
abbr gco "git checkout"
abbr gb "git branch"
abbr ga "git add"
abbr gs "git status -sb"

# Git log aliases
abbr glog "git log --graph --pretty=format:'%C(yellow)%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
abbr glog2 "git log --graph --full-history --all --color --pretty=format:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\""

# More complex git operations
abbr grm "git status | grep deleted | awk '{print \$3}' | xargs git rm"
abbr gchurn "git log --name-only | grep .rb | sort | uniq -c | sort -nr | head"
abbr gbd "git branch --merged | grep -Evw \"(master|production|main|develop|dev|staging)\" | xargs git branch -d"

# Typo corrections
abbr gas gs

alias git=hub

alias gl='git pull'
alias glog="git log --graph --pretty=format:'%C(yellow)%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glog2='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gs='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gchurn='git log --name-only | grep .rb | sort | uniq -c | sort -nr | head'

alias gbd='git branch --merged | grep -Ev "(master|production)" | xargs git branch -d'

# typos
alias gas=gs

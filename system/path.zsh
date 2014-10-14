export PATH=".:bin:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"

export PATH=/usr/local/heroku/bin:$PATH

export PATH=$HOME/.rvm/bin:$PATH

# add global npm modules
export PATH=/usr/local/share/npm/bin:$PATH

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

cdpath=($PROJECTS $GOPATH/src/github.com/zefer)

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

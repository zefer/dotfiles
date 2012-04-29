# todo.sh: https://github.com/ginatrapani/todo.txt-cli
function td() { 
  if [ $# -eq 0 ]; then
    todo.sh ls
  else
    todo.sh $*
  fi
}

alias n="t ls +next"

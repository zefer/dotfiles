function chpwd {
  load_dotenv_vars
}

# exports all env vars from .env in current dir, if present
function load_dotenv_vars {
  if [ -f ".env" ]; then
    # coloured output
    echo "$(tput setaf 240)adding .env to ENV$(tput sgr0)"
    export $(cat .env)
  fi
}

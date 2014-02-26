function chpwd {
  load_dotenv_vars
}

# exports all env vars from .env in current dir, if present
function load_dotenv_vars {
  if [ -f ".env" ]; then
    echo "adding .env to ENV"
    export $(cat .env)
  fi
}

export LC_MESSAGES=
if [ ! -f "${HOME}/.gpg-agent-info" ]; then
	eval $(gpg-agent --daemon --write-env-file)
fi
if [ -d "${HOME}/dotfile" ]; then
  (cd "${HOME}/dotfile" && git pull) &
fi

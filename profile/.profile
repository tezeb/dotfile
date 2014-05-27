export LC_MESSAGES=
if [ ! -f "${HOME}/.gpg-agent-info" ]; then
	eval $(gpg-agent --daemon --write-env-file)
fi

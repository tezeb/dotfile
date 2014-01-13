#!/bin/bash
#syndaemon -t -k -d -i 2
(sleep 1 && lxpanel) &
xsetroot -solid black -cursor_name left_ptr
xrdb .Xresources
xscreensaver -no-splash &
rm -f "${HOME}/.gpg-agent-info"
if [ ! -f "${HOME}/.gpg-agent-info" ]; then
  eval $(gpg-agent --daemon --write-env-file)
fi
#exec ratpoison

#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

syndaemon -t -k -d -i 2
(sleep 1 && lxpanel) &
xsetroot -solid black -cursor_name left_ptr
xrdb .Xresources
nohup xbindkeys &
xscreensaver -no-splash &
rm -f "${HOME}/.gpg-agent-info"
if [ ! -f "${HOME}/.gpg-agent-info" ]; then
  eval $(gpg-agent --daemon --write-env-file)
fi
exec /usr/bin/ratpoison

#	from Gentoo :)
if [[ $- != *i* ]]; then
	#	Shell is non-intercative(ie. scp, rcp)
	return
fi
unset command_not_found_handle
alias ls="ls --color=always"
export EDITOR="vim"
export LANG=en_GB.utf8

# User specific aliases and functions
#alias gcc='gcc -O -Wall -pedantic --std=c99 -Wshadow -pedantic-errors -Wtraditional'
alias gcc='gcc -O -Wall -Wextra -pedantic --std=c99 -Wshadow -pedantic-errors'
alias g++='g++ --std=c++0x -Wall -Wextra -Werror -pedantic -pedantic-errors -Wshadow'
alias grep='grep --color=auto'

#   this variables are used with make counter
#   checking how often make is run
export WORKDAY_INTERVAL=$(( 12*60*60 ))

#export LD_LIBRARY_PATH=~/mroot/usr/lib:~/mroot/usr/local/lib

#	TODO: install cppunit
#CPPUNIT_FLAGS=`~/mroot/usr/local/bin/cppunit-config --libs` 
#CPPUNIT_FLAGS+=" -I/home/tzp2z7/mroot/usr/local/include/"
#export CPPUNIT_FLAGS

#eval $( dircolors -b $HOME/.DIR_COLORS )

GREP_COLORS=$GREP_COLORS
#eval $(perl -I$HOME/mroot/usr/lib/perl5 -Mlocal::lib=$HOME/mroot/usr/)
#export MANPATH=/usr/share/man:~/mroot/usr/share/man/
#	for idea to work with proprietary java
export IDEA_JDK=/opt/java6/

source "$HOME"/.preexec.bash
function preexec() {
  __internal_timer=$SECONDS;
#  echo "preexec" $1 " > " $__internal_timer;
}
function precmd() {
  __internal_timer_show=$(($SECONDS - ${__internal_timer:-0}))
#    echo $__internal_timer_show;
  unset __internal_timer
}

export HISTTIMEFORMAT="%F %R %z "
hostnamecolor=$(hostname | od | tr ' ' '\n' | awk 'BEGIN{i=10}{total = total + $1*i; i=i+10}END{print (total % 256)}')
HOSTNAME=$(hostname)
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\u@\[$(tput setaf $hostnamecolor)\]${HOSTNAME}\[$(tput setaf 4)\]:\W]\[$(tput setaf 34)\]\$([[ \$? -ne 0 ]] && echo '\['$(tput setaf 1)'\]')(\${__internal_timer_show}s[\D{%H:%M}])\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"
#	disable ^S from sleeping terminal
stty -ixon

function cd() {
	if [ -z "$*" ]; then
		builtin cd
	else
		builtin cd "$*"
	fi
	unset CSCOPE_DB
	tmp=`pwd`
	while [ "$tmp" != "" ]; do
			if [[ -f "$tmp"/cscope.out ]]; then
					export CSCOPE_DB="$tmp"/cscope.out;
					break;
			fi;
			tmp=${tmp%/*};
	done
}

export HISTCONTROL=ignoredups:ignorespace:erasedups
export HISTTIMEFORMAT="%F %R %z "
export HISTFILESIZE=4096
export HISTSIZE=4096
export HISTIGNORE="clear"
command -v ruby 1>/dev/null && export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PATH=$PATH:"$GEM_HOME/bin"
alias less="less -RFX"

preexec_install

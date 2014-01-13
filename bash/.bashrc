alias ls="ls --color=auto"
export EDITOR="vim"
export LANG=en_GB.utf8
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --write-env-file)
fi

# User specific aliases and functions
#alias gcc='gcc -O -Wall -pedantic --std=c99 -Wshadow -pedantic-errors -Wtraditional'
alias gcc='gcc -O -Wall -pedantic --std=c99 -Wshadow -pedantic-errors'
alias g++='g++ --std=c++0x -Wall -Werror -pedantic -pedantic-errors -Wshadow'
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

unset command_not_found_handle
GREP_COLORS=$GREP_COLORS
#eval $(perl -I$HOME/mroot/usr/lib/perl5 -Mlocal::lib=$HOME/mroot/usr/)
#export MANPATH=/usr/share/man:~/mroot/usr/share/man/
#	for idea to work with proprietary java
export IDEA_JDK=/opt/java6/

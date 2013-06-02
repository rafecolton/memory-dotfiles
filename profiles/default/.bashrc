# NOTE: this file should only contain non-interactive things like umask,
# environmental variables, whereas ~/.bash_profile should contain all
# interactive-type things like aliases, functions, and the fancy PS1

umask 027

export GIT_PS1_SHOWSTASHSTATE="<nonempty>"
export GIT_PS1_SHOWUNTRACKEDFILES="<nonempty>"
export GIT_PS1_SHOWDIRTYSTATE="<nonempty>"
export GIT_PS1_SHOWUPSTREAM="auto"

set -o vi

export PATH="$PATH:/usr/local/mysql/bin:/opt/local/bin:/usr/local/sbin"
export EDITOR=vim
export RAILS_ENV=development
export TERM=xterm-color
export PAGER='less -FSRX'

export SDC_CLI_URL="https://us-sw-1.api.joyentcloud.com"
export SDC_CLI_ACCOUNT=modclothdev

if [ -d /usr/local/Cellar/go ] ; then
  export GOROOT="/usr/local/Cellar/go/`ls /usr/local/Cellar/go | tail -1`"
fi

for f in .bashrc.local .bashrc_local .bashrc_$(whoami) ; do
  test -s "$HOME/$f" && source "$HOME/$f"
done

if [ -d "$HOME/.bashrc.d" ] ; then
  for f in $(find "$HOME/.bashrc.d" -type f -name '*.sh') ; do
    source "$f"
  done
fi

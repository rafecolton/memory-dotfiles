# NOTE: this file should only contain non-interactive things like umask,
# environmental variables, whereas ~/.bash_profile should contain all
# interactive-type things like aliases, functions, and the fancy PS1

umask 027

export GIT_PS1_SHOWSTASHSTATE="<nonempty>"
export GIT_PS1_SHOWUNTRACKEDFILES="<nonempty>"
export GIT_PS1_SHOWDIRTYSTATE="<nonempty>"
export GIT_PS1_SHOWUPSTREAM="auto"

set -o vi

function add_to_path_before {
  if [ ! -z $1 ] && ! echo $PATH | grep -q "$1" ; then
    export PATH="$1:$PATH"
  fi
}

function add_to_path_after {
  if [ ! -z $1 ] && ! echo $PATH | grep -q "$1" ; then
    export PATH="$PATH:$1"
  fi
}

for path in "/usr/local/sbin" "/opt/local/bin" "/usr/local/mysql/bin" ; do
  add_to_path_after "$path"
done

export EDITOR=vim
export RAILS_ENV=development
export TERM=xterm-256color
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

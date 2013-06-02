source ~/.bashrc

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function grep-src { grep "$1" * -r --color=auto $2 $3 $4 --exclude=*\.log --exclude tags; }

function is_darwin() {
  uname -v | grep -i 'darwin' > /dev/null && [ $? -eq 0 ]
}

function is_linux() {
  uname -v | grep -i 'linux' > /dev/null && [ $? -eq 0 ]
}

function is_joyent() {
  uname -v | grep -i 'joyent' > /dev/null && [ $? -eq 0 ]
}

if is_darwin ; then
  BREW_PREFIX=`brew --prefix`
  alias ctags="$BREW_PREFIX/bin/ctags"
  alias gvim="mvim --remote-send '<C-w>n'; mvim --remote-silent"
  alias vi='mvim -v'
  alias vim='mvim -v'
  export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"  # used by homebrew, plus it's sensible enough

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

if is_linux ; then
  alias vi='vim'
fi

if is_joyent ; then
  export ac_cv_func_dl_iterate_phdr='no'
  export rb_cv_have_signbit='no'
  export C_INCLUDE_PATH='/opt/local/include'
  export LIBRARY_PATH='/opt/local/lib:/lib/secure/64:/usr/lib/secure/64:/opt/local/gcc47/lib/amd64'
fi

export RUBY_CONFIGURE_OPTS="--disable-install-doc"
export RUBY_MAKE_OPTS=""

alias .g='source ~/.bash_profile'
alias a='activate'
alias ca='activate_cookbook'
alias be='bundle exec'
alias tbe='time bundle exec'
alias t='time'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'
alias rdb='bundle exec rails dbconsole'
alias l='ls -lFG'
alias ll='ls -laFG'
alias sc='script/console'
alias ss='script/server'
alias sdb='script/dbconsole'

export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="l:ll:pwd:vmf:dvmf:isp"
export HISTFILESIZE=100000000
export HISTSIZE=1000000
shopt -s histappend # append instead of rewrite

# makes git grep wrap long lines instead of cutting them short
export LESS=FRX

if [ -d "$HOME/bin" ]; then
  export PATH=$HOME/bin:$PATH
fi

for completion_file in $(find $HOME/.bash_completion.d/ -type f)
do
  if [ ! -x "$completion_file" ]; then
    source "$completion_file"
  fi
done

export PS1="\e[32m[\t]\e[0m \u@${NODENAME:=$HOSTNAME}\e[33m [\w]\e[0m \$(parse_git_branch) \$(show_chef_env 2>/dev/null)\n> "

if [ -d "$HOME/.rbenv" ]; then
  export PATH=$PATH:~/.rbenv/bin
  eval "$(rbenv init -)"
  export PATH=$PATH:~/.rbenv/shims
fi

if [ -d "$HOME/.bash_profile.d" ] ; then
  for f in $(find "$HOME/.bash_profile.d" -type f -name '*.sh') ; do
    source "$f"
  done
fi

eval $(ssh-agent)

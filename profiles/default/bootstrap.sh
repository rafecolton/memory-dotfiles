#!/usr/bin/env bash

set -e
set -x

_install_tmux() {
  if is_darwin ; then
    pushd $HOME
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    popd
    brew install tmux
    brew install reattach-to-user-namespace
  elif is_linux ; then
    # un-tested
    sudo apt-get install tmux
    # sudo apt-get reattach-to-user-namespace # <- is this necessary?
  fi
}

_install_gems() {
  for gem in bundler rake git-duet ; do
    gem install "$gem"
  done
}

_install_rbenv() {
  pushd "$HOME" >/dev/null
  rm -rf .rbenv
  git clone git://github.com/sstephenson/rbenv.git .rbenv
  mkdir -p .rbenv/plugins
  git clone git://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build
  git clone git://github.com/sstephenson/rbenv-gem-rehash.git .rbenv/plugins/rbenv-gem-rehash
  cat > .bashrc.d/rbenv.sh <<EOF
export PATH="\$HOME/.rbenv/bin:\$PATH"
EOF
  cat > .bash_profile.d/rbenv.sh <<EOF
  eval "\$(rbenv init -)"
EOF
  rbenv install 1.9.3-p392
  rbenv global 1.9.3-p392
}

_install_janus() {
  pushd "$HOME" >/dev/null
  for f in .vimrc .gvimrc .vim ; do
    rm -rf "$f"
  done
  git clone https://github.com/carlhuda/janus.git .vim

  pushd .vim >/dev/null
  logfile=/tmp/janus-install.log
  echo "----> Installing Janus.  Log at $logfile"
  date > "$logfile"
  rake >> "$logfile" 2>&1
  echo
  popd >/dev/null
  popd >/dev/null
}

main() {
  _install_rbenv
  _install_gems
  _install_janus
  _install_tmux
  source ~/.bash_profile
  rm -f $(dirname $0)/$(basename $0)
}

main "$*"

#!/usr/bin/env bash

set -e

_install_gems() {
  for gem in bundler rake git-duet ; do
    gem install "$gem"
  done
}

_install_rbenv() {
  pushd "$HOME" >/dev/null
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
  _install_gems
  _install_rbenv
  _install_janus
  source ~/.bash_profile
}

main "$*"

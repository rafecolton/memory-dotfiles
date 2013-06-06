GIT="git --git-dir=$GIT_DIR --work-tree=$GIT_WORK_TREE"

git_init_all() {
  mkdir -p "$GIT_DIR"
  mkdir -p "$GIT_REMOTE"
  git --git-dir="$GIT_REMOTE" init --bare -q
  eval "$GIT init -q"
  eval "$GIT config user.email 'autobot@decepticon.mdf'"
  eval "$GIT config user.name 'Autobot Decepticon'"
  eval "$GIT remote add backup $GIT_REMOTE"
  echo "$(date)" > "$GIT_WORK_TREE/.mdf"
  eval "$GIT add $GIT_WORK_TREE/.mdf"
  eval "$GIT commit -q -m 'Initial commit'"
  eval "$GIT push -q -u backup master"
}

git_commit() {
  eval "$GIT commit -q -m '${1:-$(date_utc_iso8601) Saving files}'"
}

git_push() {
  eval "$GIT push -q -u backup ${1:-master}"
}

git_commit_push() {
  git_commit
  git_push "${1:-master}"
}

#TODO: explicitly test this
remote_branches_includes_profile() {
  if [ -z $1 ] ; then exit 1 ; fi
  local profile="$1"
  local remote_name="${2:-backup}"
  eval "$GIT branch -r --list '$remote_name/*' | grep -q $profile"
}

# The below two functions are necessary because
# there is a bug in `git` such that it will not
# honor the --work-tree option for the git-stash
# command.  Instead, `git stash` must be run from
# *within* the working tree.

git_stash() {
  pushd "$GIT_WORK_TREE"
  git --git-dir="$GIT_DIR" stash
  popd
}

git_stash_pop() {
  pushd "$GIT_WORK_TREE"
  git --git-dir="$GIT_DIR" stash pop
  popd
}

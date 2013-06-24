use() {
  # profile must be specified
  if [ -z $1 ] ; then
    echoerr 'You must specify a profile to use'
    exit 2
  fi
  local profile="$1"

  # Determine if a branch already exists for the profile.
  # If not, then there must be a valid directory for the
  # profile.
  local has_profile=1
  if git_remote_branches_includes_profile "$profile" ; then
    has_profile=0
  elif [ ! -e "$PROFILE_DIR/$profile" ] ; then
    echoerr 'You must specify a valid profile to use'
  fi

  # restore original home directory first
  restore
  if [ $profile == 'master' ] ; then return 0 ; fi

  # `git add`, `git commit`, and `git push` for
  # original home directory
  quietly "git_add_profile_contents \"$profile\""
  quietly "git_commit_push 'master'"

  # either check out a new branch or, if a branch already
  # exists for the selected profile, check it out instead
  if [ $has_profile -eq 0 ] ; then
    quietly "eval \"$GIT checkout -q '$profile'\""
  else
    quietly "eval \"$GIT checkout -q -b '$profile'\""
  fi

  # copy profile contents into git work tree
  rsync -aqz --safe-links "$PROFILE_DIR/$profile/" "$GIT_WORK_TREE"

  # make sure the current user owns all dotfiles
  for file in $(ls -1A "$PROFILE_DIR/$profile/") ; do
    chown -R $(whoami) "$GIT_WORK_TREE/$file"
  done

  # Once the new files have been added to the home
  # directory, put them under version control.That
  # way, the next time the profile is used, the
  # branch can be checked out and the files don't
  # need to be copied over again.
  quietly "git_add_profile_contents \"$profile\""
  quietly "git_commit_push \"$profile\""
}

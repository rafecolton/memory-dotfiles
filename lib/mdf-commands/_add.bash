add() {
  ARGS=$(getopt -o d:r:n: --long dir:,repo:,name: -n "$(basename $0)" -- "$@")
  if [ $? != 0 ] ; then echoerr 'Terminating...' ; exit 1 ; fi
  eval set -- "$ARGS"

  local dir=''
  local repo=''
  local name=''

  while : ; do
    case $1 in
      -d|--dir)
        dir="$2"
        shift 2
        ;;
      -r|--repo)
        repo="$2"
        shift 2
        ;;
      -n|--name)
        name="$2"
        shift 2
        ;;
      --)
        shift
        break
        ;;
      -*)
        echowarn "WARN: unknown option (ignored): $1"
        shift
        ;;
      *) # no more options
        break
        ;;
    esac
  done

  if [ -z "$dir" ] && [ -z "$repo" ] ; then
    echoerr 'You must specify either directory or a repository to add.'
    help_add
    exit 1
  elif [ ! -z "$dir" ] && [ ! -z "$repo" ] ; then
    echoerr 'You may not specify both a directory and a repository.'
    help_add
    exit 2
  fi

  if [ ! -z "$dir" ] ; then # directory specified

    # ensure $dir exists and is directory
    if [ ! -d "$dir" ] || [ -L "$dir" ] ; then
      echoerr "$dir is not a valid directory. The directory specified must be\nvalid and may not be a symlink."
      exit 3
    fi

    # determine profile name
    if [ -z "$name" ] ; then name="$(basename "$dir")" ; fi

    # make sure profile doesn't already exist
    for profile in $(find "$PROFILE_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;) ; do
      if echo "$dir" | grep -qi "^$profile\$" ; then
        echoerr "Profile named '$name' already exists."
        exit 5
      fi
    done

    # copy files over
    mkdir "$PROFILE_DIR/$name"
    rsync -aqz --safe-links "$(dirname "$dir")/$(basename "$dir")/" "$PROFILE_DIR/$name"

  else # repository specified
    # check if repo is valid
    git ls-remote "$repo" >/dev/null 2>&1
    if [ $? -ne 0 ] ; then
      echoerr "$repo is not a valid repository."
      exit 4
    fi

    # attempt to clone down, will fail if name conflict
    pushd $PROFILE_DIR >/dev/null
    if [ ! -z "$name" ] ; then
      git clone "$repo" "$name" >/dev/null 2>&1
      if [ $? -ne 0 ] ; then
        echoerr "A profile with name '$name' already exists."
        exit 5
      fi
    else
      git clone "$repo" >/dev/null 2>&1
      if [ $? -ne 0 ] ; then
        echoerr "A profile already exists with your repository's name.  Please specify another name"
      fi
    fi
    popd >/dev/null
  fi
}

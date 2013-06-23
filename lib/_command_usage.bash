help() {
  if [ $# -lt 1 ] ; then
    cat <<EOB

  Usage: mdf help <command>

  Please specify a valid command to learn more about it.

  To see a list of available commands, use \`mdf --help\`

  Happy coding!
EOB
    exit 0
  fi

  COMMAND=$1

  for cmd in --help -h usage list restore uninstall use version --version help ; do
    if [ $cmd == "$1" ] ; then
      if [ "$1" == 'help' ] ; then
        help
      else
        help_${cmd//-/}
        echo -e "\n  Happy coding!"
      fi
      exit 0
    fi
  done
}

help_h() {
  help_usage
}

help_help() {
  help_usage
}

help_usage() {
  cat <<EOB

  Usage: mdf <usage | --help | -h>

  Displays list of available commands
EOB
}

help_list() {
  cat <<EOB

  Usage: mdf list

  Lists available profiles
EOB
}

help_restore() {
  cat <<EOB

  Usage: mdf restore

  Restores the original files present in \$MDF_WORK_TREE at the time mdf was
  first used.

  NOTE: Files that were not present in the \$MDF_WORK_TREE at the time of
  initial use will remain in the \$MDF_WORK_TREE after restoration.
EOB
}

help_uninstall() {
  cat <<EOB

  Usage: mdf uninstall [options]

  Options:
  [--clean|-c]  : restore before uninstalling (see \`mdf help restore\` for more information)

  Removes the mdf executable as well as any supporting files.
EOB
}

help_use() {
  cat <<EOB

  Usage: mdf use <profile>

  Uses any files available in \$MDF_VAR_PATH/profiles/<profile> to replace
  files with the same name in \$MDF_WORK_TREE.  Currently, only the 'default'
  profile is available.  Support for additional profiles will soon be added!

  See \`mdf help list\` to see more information on available profiles.
EOB
}

help_version() {
  cat <<EOB

  Usage: mdf <version | --verison>

  Prints version and exits.
EOB
}

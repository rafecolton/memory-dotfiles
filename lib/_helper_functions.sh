GOLD="\033[33;1m"
RESET="\033[0m"
GREEN="\033[32m"
RED="\033[31m"
BRIGHT_GREEN="\033[32;1m"
BRIGHT_RED="\033\[31;1m"

echoerr() {
  echo -e "$RED$1$RESET"
}

quietly() {
  command=${1-:}
  eval "$command >/dev/null 2>&1"
  if [ $? -ne 0 ] ; then
    exitval=$?
    echoerr "Error running '$command'"
    exit $exitval
  fi
}

date_utc_iso8601() {
  echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}

# not really necessary, just here for fun
systems=(darwin linux joyent)
for system in ${systems[@]} ; do
  eval "
    is_$system() {
      uname -v | grep -qi '$system'
    }
  "
done

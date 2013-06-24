uninstall() {
  echo 'uninstalling mdf...'
  if [ "$1" == '--clean' ] || [ "$1" == "-c" ] ; then restore ; fi
  quietly "if [ -f \"$BIN_PATH/mdf\" ] ; then rm \"$BIN_PATH/mdf\" ; fi"
  quietly "if [ -d \"$VAR_PATH\" ] ; then rm -rf \"$VAR_PATH\" ; fi"
  echo 'done'
}

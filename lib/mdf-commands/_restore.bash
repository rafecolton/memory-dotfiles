restore() {
  quietly "$GIT reset -q --hard"
  quietly "$GIT checkout -q master"
}

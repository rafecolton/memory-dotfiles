list() {
  echo -e "\nProfiles\n========"
  find "$PROFILE_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;
}

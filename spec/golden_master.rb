require 'spec/spec_helper'

describe 'using a profile and then restoring' do
  it 'leaves the files unchanged after restoring' do
    files = file_list(DEFAULT_PROFILE_DIR)
    hash_list_before = home_hash_list(files)

    # do stuff
    shell_out 'mdf use default', true
    shell_out 'mdf restore', true

    hash_list_after = home_hash_list(files)
    hash_list_before.must_equal hash_list_after
  end
end

describe 'listing profiles' do
  it 'lists the default profile' do
    `mdf list`.strip.must_equal "Profiles\n========\ndefault"
  end
end

def file_list(dir)
  `find #{dir} -xdev -type f`.
    chomp.
    split("\n").
    map{ |f| f.gsub(/^#{dir}\//, '') }
end

def home_hash_list(file_list = [])
  file_list.map do |file|
    `#{<<-EOB}`.chomp
    if [ -f "$HOME/#{file}" ] ; then
      cat "$HOME/#{file}" | openssl md5
    else
      echo 'not present' | openssl md5
    fi
  EOB
  end
end

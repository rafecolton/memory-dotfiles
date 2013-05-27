require 'spec/spec_helper'

describe 'using a profile and then restoring' do
  it 'leaves the files unchanged after restoring' do
    files = file_list(DEFAULT_PROFILE_DIR)
    hash_list_before = home_hash_list(files)

    # TODO: use the default profile
    # TODO: restore from backup

    hash_list_after = home_hash_list(files)

    hash_list_before.must_equal hash_list_after
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
      bash -c "md5 -q \"$HOME/#{file}\""
    else
      bash -c "md5 -qs 'not present'"
    fi
  EOB
  end
end

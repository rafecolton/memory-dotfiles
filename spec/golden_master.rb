require 'spec/spec_helper'

describe 'using a profile and then restoring' do
  let(:files){ file_list(DEFAULT_PROFILE_DIR) }
  before do
    @hash_list_before = home_hash_list(files)
  end

  it 'leaves the files unchanged after restoring' do
    shell_out 'mdf use default'
    shell_out 'mdf restore'
  end

  # covers a bug that previously existed
  it 'also works when run from a different directory' do
    shell_out <<-EOB
      pushd $HOME >/dev/null
      mdf use default
      mdf restore
      popd >/dev/null
    EOB
  end

  after do
    hash_list_after = home_hash_list(files)
    hash_list_after.each_with_index do |item, index|
      item.must_equal @hash_list_before[index]
    end
  end
end

describe 'listing profiles' do
  it 'lists the default profile' do
    `mdf list`.strip.must_equal "Profiles\n========\ndefault"
  end
end

def file_list(dir)
  `find #{dir} -mindepth 1 -maxdepth 1 -type f`.
    chomp.
    split("\n").
    map{ |f| f.gsub(/^#{dir}\//, '') }
end

def home_hash_list(file_list = [])
  file_list.map do |file|
    "#{file} => #{`#{<<-EOB}`.chomp}"
    if [ -f "$HOME/#{file}" ] ; then
      cat "$HOME/#{file}" | openssl md5
    else
      echo 'not present' | openssl md5
    fi
  EOB
  end
end

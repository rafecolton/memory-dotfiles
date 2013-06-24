require 'minitest/spec'

GOLD = "\033\[33;1m"
RESET = "\033\[0m"
GREEN = "\033\[32m"
RED = "\033\[31m"
BRIGHT_GREEN = "\033\[32;1m"
BRIGHT_RED = "\033\[31;1m"
DEFAULT_PROFILE_DIR = File.expand_path('./profiles/default')

def shell_out(command = '', show_output = false)
  system 'bash', '-c', "#{command}#{show_output ? '' : ' >/dev/null 2>&1'}"
  unless $? == 0
    $stderr.puts %Q(#{RED}Error running `#{command}`#{RESET})
    exit $?.to_i
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

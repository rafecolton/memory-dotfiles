require 'minitest/autorun'
#require 'minitest/spec'

GOLD = "\033\[33;1m"
RESET = "\033\[0m"
GREEN = "\033\[32m"
RED = "\033\[31m"
BRIGHT_GREEN = "\033\[32;1m"
BRIGHT_RED = "\033\[31;1m"
DEFAULT_PROFILE_DIR = File.expand_path('./profiles/default')

def shell_out(command = '', show_output = false)
  system "#{command}#{show_output ? '' : ' 1>/dev/null'}"
  unless $? == 0
    $stderr.puts %Q(#{RED}Error running `#{command}`#{RESET})
    exit $?.to_i
  end
end

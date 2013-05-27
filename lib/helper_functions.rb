GOLD = "\033\[33;1m"
RESET = "\033\[0m"
GREEN = "\033\[32m"
RED = "\033\[31m"
BRIGHT_GREEN = "\033\[32;1m"
BRIGHT_RED = "\033\[31;1m"
DEFAULT_PROFILE_DIR = File.expand_path('./profiles/default')

module HelperFunctions
  private

  def shell_out(command = '', show_output = false)
    system "#{command}#{show_output ? '' : ' 1>/dev/null'}"
    unless $? == 0
      $stderr.puts %Q(#{RED}Error running `#{command}`#{RESET})
      exit $?.to_i
    end
  end

  def valid_commands
	@valid_commands ||= %w(
	  --help
	  -h
	  list
	  restore
	  uninstall
	  usage
	  use
	).map(&:to_sym)
  end

  #defines :darwin?, :linux?, and :joyent? for detecting OS
  %w(darwin linux joyent).each do |os|
	define_method "#{os}?".to_sym do
	  instance_variable_set("@#{os}", (
		instance_variable_get("@#{os}") ||
		(`uname -v | grep -i '#{os}'`.chomp =~ /#{os}/i && true)
	  ))
	end
  end
end

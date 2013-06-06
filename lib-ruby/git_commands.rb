require 'time'

module GitCommands
  private

  def git
    @git ||= "git --git-dir=#{git_dir} --work-tree=#{git_work_tree}"
  end

  def git_init_all
    unless File.exists?(git_dir) && File.directory?(git_dir)
      shell_out <<-EOB
        set -e
        mkdir -p #{git_dir}
        mkdir -p #{git_remote}
        git --git-dir=#{git_remote} init --bare -q
        #{git} init -q
        #{git} config user.email 'autobot@decepticon.mdf'
        #{git} config user.name 'Autobot Decepticon'
        #{git} remote add backup #{git_remote}
        echo $(date) > #{git_work_tree}/.mdf
        #{git} add #{git_work_tree}/.mdf
        #{git} commit -q -m 'initial commit'
        #{git} push -q -u backup master >/dev/null 2>&1
      EOB
    end
  end

  def git_commit(message = "#{Time.now.utc.iso8601} Saving files")
    "#{git} commit -q -m '#{message}' >/dev/null 2>&1"
  end

  def git_push(branch = 'master')
    "#{git} push -q -u backup #{branch} >/dev/null 2>&1"
  end

  def git_commit_push(branch = 'master')
    shell_out <<-EOB
      #{git_commit}
      #{git_push(branch)}
    EOB
  end

  def remote_branches(remote_name = 'backup')
    `#{git} branch -r`.
    chomp.
    split("\n").
    map{ |b| b.gsub(/#{remote_name}\//, '') }.
    map(&:strip)
  end

  # The below two functions are necessary because
  # there is a bug in `git` such that it will not
  # honor the --work-tree option for the git-stash
  # command.  Instead, `git stash` must be run from
  # *within* the working tree.
  def git_stash
    shell_out <<-EOB
      pushd #{git_work_tree}
      git --git-dir=#{git_dir} stash
      popd
    EOB
  end

  def git_stash_pop
    shell_out <<-EOB
      pushd #{git_work_tree}
      git --git-dir=#{git_dir} stash pop
      popd
    EOB
  end
end

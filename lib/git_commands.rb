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
        git --git-dir=#{git_remote} --bare init -q
        #{git} init -q
        #{git} remote add -m master backup #{git_remote}
        EOB
    end
  end

  def git_push(branch = 'master')
    "#{git} push -u backup #{branch}"
  end
end

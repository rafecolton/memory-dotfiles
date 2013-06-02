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
        #{git} remote add backup #{git_remote}
        touch #{git_work_tree}/.mdf
        #{git} add #{git_work_tree}/.mdf
        #{git} commit -q -m 'initial commit'
        #{git} push -q -u backup master > /dev/null
      EOB
    end
  end

  def git_push(branch = 'master')
    "#{git} push -q -u backup #{branch}"
  end

  # The below two functions are necessary because
  # there is a bug in `git` such that it will not
  # honor the --work-tree option for the git-stash
  # command.  Instead, `git stash` must be run from
  # *within* the working tree.
  def git_stash
    <<-EOB
      pushd #{git_work_tree}
      git --git-dir=#{git_dir} stash
      popd
    EOB
  end

  def git_stash_pop
    <<-EOB
      pushd #{git_work_tree}
      git --git-dir=#{git_dir} stash pop
      popd
    EOB
  end
end

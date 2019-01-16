require 'bundler'

module GemfileLockJuicer
  class << self
    def squeeze repository, gemfile_lock, gem_name
      lock_file = Bundler::LockfileParser.new gemfile_lock
      spec = lock_file.specs.find { |s| s.name == gem_name }
      gems << [repository, spec.version] if spec
    end

    def print
      gems.sort_by { |_name, version| version }
          .reverse_each { |repo, version| printf "%-35s %s\n", repo, version }
    end

    private

    def gems
      @gems ||= []
    end
  end
end

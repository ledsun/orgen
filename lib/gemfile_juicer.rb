require_relative 'gemfile_evaluator'

module GemfileJuicer
  class << self
    def squeeze repository, gemfile
      GemfileEvaluator.new(repository).instance_eval gemfile
    end

    def print
      GemfileEvaluator.gems
                      .sort_by { |_key, value| -value.count }
                      .each { |gem_name, use_repos| printf "%-45s %-2s %s\n", gem_name, use_repos.count, use_repos }
    end
  end
end

class GemfileEvaluator
  @gems = {}

  class << self
    attr_reader :gems
  end

  def initialize repository
    @repo = repository
  end

  def gems
    self.class.gems
  end

  private

  def do_nothing *_args
    yield '' if block_given?
  end

  alias source do_nothing
  alias group do_nothing
  alias ruby do_nothing
  alias git_source do_nothing
  alias gemspec do_nothing

  def gem *args
    gem_name = args[0]

    if gems[gem_name]
      gems[gem_name] << @repo
    else
      gems[gem_name] = [@repo]
    end
  end
end

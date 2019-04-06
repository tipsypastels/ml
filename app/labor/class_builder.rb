class ClassBuilder
  def self.for(opts)
    new(opts)
  end

  def initialize(opts)
    @opts = opts
    @opts[:class] ||= ''
  end

  def add(name)
    ary = @opts[:class].split(' ')
    ary << name
    @opts[:class] = ary.join(' ')
  end
end
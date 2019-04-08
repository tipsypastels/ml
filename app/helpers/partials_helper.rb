module PartialsHelper
  def rp(name, **locals)
    render partial: name, locals: locals
  end

  def rc(name, collection, cached: true, **opts)
    render partial: name, collection: collection, cached: cached, **opts
  end

  def rl(name, **locals, &block)
    render layout: name, locals: locals, &block
  end
end
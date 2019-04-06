module PartialsHelper
  def rp(name, **locals)
    render partial: name, locals: locals
  end
end
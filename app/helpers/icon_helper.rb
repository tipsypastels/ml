module IconHelper
  def fa(icon, group = 'fas', **opts)
    opts[:class] = "#{group} fa-#{icon} #{opts[:class]}"
    content_tag :i, nil, **opts
  end
end
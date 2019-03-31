module IconHelper
  def fa(icon, group = 'fas')
    content_tag :i, nil, class: "#{group} fa-#{icon}"
  end
end
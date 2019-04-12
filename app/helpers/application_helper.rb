module ApplicationHelper
  def menu_li(text:, to:, icon: nil, **opts)
    icon_html = 
      if icon 
        content_tag(:span, fa(icon), class: 'icon is-small') 
      end

    text_html = content_tag(:span, text)

    content = [icon_html, text_html].join.html_safe

    content_tag(:li, 
      link_to(content, to, **opts)
    )
  end
end

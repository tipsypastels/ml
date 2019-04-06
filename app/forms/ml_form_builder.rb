class MlFormBuilder < ActionView::Helpers::FormBuilder
  OVERRIDE_WITH_ICON_SUPPORT = %i|
    text_field email_field password_field
  |
  
  OVERRIDE_WITH_ICON_SUPPORT.each do |method|
    define_method method do |field, **opts|
      return super(field, **opts) unless opts[:icon]
    
      <<~HTML.html_safe
        <p class="control has-icons-left">
          <span class="icon is-small is-left">
            <i class="fas fa-#{opts[:icon]}"></i>
          </span>
          #{super(field, **opts)}
        </p>
      HTML
    end
  end
end
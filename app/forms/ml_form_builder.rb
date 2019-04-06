class MlFormBuilder < ActionView::Helpers::FormBuilder
  OVERRIDE_WITH_ICON_SUPPORT = %i|
    text_field number_field email_field password_field
  |
  
  OVERRIDE_WITH_ICON_SUPPORT.each do |method|
    define_method method do |field, **opts|
      return super(field, **opts) unless opts[:icon]
      icon_group = opts[:icon_group] || 'fas'

      <<~HTML.html_safe
        <p class="control has-icons-left">
          <span class="icon is-small is-left">
            <i class="#{icon_group} fa-#{opts[:icon]}"></i>
          </span>
          #{super(field, **opts)}
        </p>
      HTML
    end
  end

  def label(field, **opts)
    opts[:class] ||= ''
    opts[:class] << " label"
    super
  end

  def select(field, values, **opts)
    klass = opts.delete(:class)

    core = <<~HTML
      <div class="select #{klass}">
        #{super}
      </div>
    HTML

    return core.html_safe unless opts[:icon]

    <<~HTML.html_safe
      <div class="control has-icons-left">
        #{core}
        <span class="icon is-small is-left">
          <i class="fas fa-#{opts[:icon]}"></i>
        </span>
      </div>
    HTML
  end

  def smart_select(field, values, **opts)
    # TODO this is a bit messy
    mapped_values = values.map do |key, _|
      [key.humanize, key]
    end

    select(field, mapped_values, **opts)
  end

  def file_field(field, label = 'Choose a file…', boxed: false, **opts)
    klass = opts.delete(:class)
    
    <<~HTML.html_safe
      <div class="file #{'is-boxed' if boxed} #{klass}">
        <label class="file-label">
          #{super(field, class: 'file-input', **opts)}
          <span class="file-cta">
            <span class="file-icon">
              <i class="fas fa-upload"></i>
            </span>

            <span class="file-label">
              #{label}
            </span>
          </span>
        </label>
      </div>
    HTML
  end
end
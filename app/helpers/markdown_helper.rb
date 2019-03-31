module MarkdownHelper
  MARKDOWN_OPTIONS = {
    filter_html:     true,
    hard_wrap:       true,
    link_attributes: { rel: 'nofollow', target: "_blank" },
    space_after_headers: true,
    fenced_code_blocks: true
  }

  MARKDOWN_EXTENSIONS = {
    autolink:                     true,
    superscript:                  true,
    disable_indented_code_blocks: true,
  }

  RENDERER = Redcarpet::Render::HTML.new(MARKDOWN_OPTIONS)
  MARKDOWN = Redcarpet::Markdown.new(RENDERER, MARKDOWN_EXTENSIONS)
  
  def markdown_for(text)
    <<~HTML.html_safe
      <div class="markdown-area">
        #{MARKDOWN.render(text)}
      </div>
    HTML
  end
end
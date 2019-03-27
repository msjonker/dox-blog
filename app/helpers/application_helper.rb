module ApplicationHelper
  def markdown(text)
    renderer = HtmlWithPygments.new(hard_wrap: true, filter_html: false)
    Redcarpet::Markdown.new(renderer, markdown_options.merge(footnotes: true)).render(text).html_safe
  end

  def author_avatar_url(author)
    default_url = asset_url("logo-inverted.png")
    gravatar_id = Digest::MD5.hexdigest(author.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=160&d=#{CGI.escape(default_url)}"
  end

  def here_class?(controller, action, id = nil)
    if params[:controller] == controller &&
      params[:action] == action &&
      params[:id] == id
      "here"
    else
      ""
    end
  end

  def emphasize_query_tokens(text, query)
    return text unless query
    tokens = Searchable.tokenize query
    regex = Searchable.to_word_delimited_regex(tokens)
    text.gsub(regex) { "**#{$&}**" }
  end

  private

  def markdown_options
    {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      lax_spacing: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true,
      with_toc_data: true
    }
  end
end

module MessagesHelper

  # # Returns sanitized HTML from input text using GitHub-flavored Markdown.
  # def markdown(text)
  #   #sanitize auto_link(Kramdown::Document.new(text, input: 'GFM').to_html)
  #   markdown = Redcarpet::Markdown.new(MdEmoji::Render, :no_intra_emphasis => true)
  #   sanitize markdown.render(text)
  # end

  ALLOW_TAGS = %w(p br img h1 h2 h3 h4 h5 h6 blockquote pre code b i
                  strong em table tr td tbody th strike del u a ul ol li span hr)
  ALLOW_ATTRIBUTES = %w(href src class width height id title alt target rel data-floor)

  def markdown(text)
    sanitize_markdown(MarkdownTopicConverter.format(text))
  end

  def sanitize_markdown(body)
    # TODO: This method slow, 3.5ms per call in topic body
    sanitize(body, tags: ALLOW_TAGS, attributes: ALLOW_ATTRIBUTES)
  end

end

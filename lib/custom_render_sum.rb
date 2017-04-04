class CustomRenderSum < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<img src="#{link}" height="#{0}" width="#{0}" alt="#{alt_text}>")
  end
end
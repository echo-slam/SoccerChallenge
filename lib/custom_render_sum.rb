class CustomRenderSum < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<img src="#{link}" height="#{100}" alt="#{alt_text}>")
  end
end
class CustomRenderSum < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<img src="#{link}" width="#{200}" alt="#{alt_text}>")
  end
end
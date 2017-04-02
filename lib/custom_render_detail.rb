class CustomRenderDetail < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<img src="#{link}" width="#{700}" alt="#{alt_text}>")
  end
end
class FetchPage

  def fetch_webpage
    url = "http://tdp.bongda24h.vn/nhan-vat-c389-p1.html"

    doc = Nokogiri::HTML(open(url))

    url_list = []
    fetch_data = []

    doc.css(".loadmore .td_tintuc_h3 a").each do |link|
      url_list.push(link["href"])
      #puts link["href"]
    end

    url_list.each do |link|
      link = URI.encode(link)

      doc = Nokogiri::HTML(open(link))
      article_title = doc.css(".post-title-singer").text
      article_content = doc.css("p+ div strong").text

      data = {title: article_title, content: article_content, url: link}
      fetch_data.push(data)
    end

    fetch_data
    
  end 

end
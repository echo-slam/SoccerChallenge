class FetchPage

  def fetch_webpage
    url = "http://tdp.bongda24h.vn/nhan-vat-c389-p1.html"

    doc = Nokogiri::HTML(open(url))

    url_list = []
    fetch_data = []
    image_url = []
    doc.css(".loadmore .td_tintuc_h3 a").each do |link|
      url_list.push(link["href"])
      #puts link["href"]
    end

    doc.css(".img_tintuc").each do |img|
      image_url.push(img['src'])
    end

    url_list.each_with_index do |link, index|
      link = URI.encode(link)

      doc = Nokogiri::HTML(open(link))
      article_title = doc.css(".post-title-singer").text
      
      article_content = doc.css("p+ div strong").text
      article_content = article_content[0..150] + "..."

      data = {title: article_title, content: article_content, image_url: image_url[index], url: link}

      fetch_data.push(data)
    end

    fetch_data

  end 

end
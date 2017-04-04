class FetchPage

  def fetch_webpage
    url = "http://tdp.bongda24h.vn/nhan-vat-c389-p1.html"
    doc = Nokogiri::HTML(open(url))

    url_list = []
    doc.css(".box-ban-doc .list_tintuc-item:nth-child(1) .td_tintuc_h3 , .post-title-entry a").each do |link|
      url_list.push(link["href"])
    end

    url_list.reject!(&:nil?)
    article_url = url_list.join('')

    doc = Nokogiri::HTML(open(article_url))
    #content = doc.css(".post-title-singer , #singer-entry div+ div , strong").to_html
    content = doc.css("p+ div strong").text
    
    title = doc.css(".post-title-singer").text
    #fetch_data = {}
    fetch_data = {title: title, content: content, url: article_url}
  end 

end
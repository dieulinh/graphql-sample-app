require 'nokogiri'
require 'readability'
require 'open-uri'
class WebScraper
  def self.call(url)
    get_html(url)
  end
  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end
  def self.elements_from_selector(html, selector)
    html.css(selector)
  end
  def self.element_at_css(html, selector)
    html.at_css(selector)
  end
  def self.parse_article(url)
    begin
      source = open(url).read
      rbody = Readability::Document.new(source, tags: %w[figure article section div p img a code span pre h1 h2 h3 h4 h5 h6 br style], attributes: %w[src href], remove_empty_nodes: true)
      images = rbody.images
      images.each do |img_url|
        photo = AttachedPhoto.new
        photo.photo = File.open(img_url)
        photo.save
        rbody.content = rbody.content.replace(img_url, photo.photo.web.url)
      end
      {
        title: rbody.title,
        content: rbody.content
      }
    rescue
      Article.new
    end
  end
end
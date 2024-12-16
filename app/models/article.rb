class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many_attached :photos

  default_scope -> { where(published: true) }
  # def self.parse(url_str)
  #   url = URI.parse(url_str)
  #   return '' if url.host.nil?
  #
  #   return
  #   url.host.repace('www','').split('.')[0]
  # end

end
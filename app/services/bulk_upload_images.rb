class BulkUploadImages
  def self.call(images)
    new_urls = []
    images.each do |img_url|
      a_photo = AttachedPhoto.new
      a_photo.remote_photo_url = img_url

      a_photo.save!
      new_urls.push a_photo.photo.web.url
    end

    new_urls.length > 0 ? new_urls.map{|url| "<img src=\"#{url}\" \/>"}.join("") : ""
  end
end
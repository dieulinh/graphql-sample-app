require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  # if Rails.env.production? || Rails.env.staging?
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = ENV['AWS_S3_BUCKET']
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_KEY'],
    region: 'ap-southeast-1',
    path_style: true
  }
  # else
  #   config.storage :file
  #   config.enable_processing = false if Rails.env.test?
  # end

end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

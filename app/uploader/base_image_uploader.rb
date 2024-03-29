class BaseImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # if Rails.env.production? || Rails.env.staging?
  #   storage :fog
  # else
  #   storage :file
  # end
  storage :fog
  process :quality => 50

  # Process files as they are uploaded:


  # version :small do
  #   process resize_to_fill: [400, 200]
  # end
  # version :cover do
  #   process resize_to_fill: [816, 612]
  # end
  version :web do
    process resize_to_fill: [600, 500]
    process :quality => 50
  end
  version :opt_web do
    process resize_to_fill: [300, 225]
    process :quality => 50
  end
  # version :icon do
  #   process resize_to_fill: [32, 32]
  # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename
  end

  private

    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or \
        model.instance_variable_set(var, SecureRandom.uuid)
    end
end

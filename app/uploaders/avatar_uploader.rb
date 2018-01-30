class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("avatars/" + [version_name, "default.png"]
                          .compact.join('_'))
  end

  version :thumb do
    process resize_to_fit: [120, 120]
  end
end

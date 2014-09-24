class SystemUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets" + asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end
end
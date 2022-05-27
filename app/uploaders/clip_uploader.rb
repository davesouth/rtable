class ClipUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "vault/clips/#{model.id.generation_time.to_s(:path)}/#{model.id}"
  end

  def cache_dir
    Rails.root.join 'tmp', 'carrierwave', 'clips'
  end

  def filename
    original_filename.parameterize if original_filename
  end

  def full_filename(for_file = model.clip.file)
    # Block uploading files named "thumb.jpg"
    for_file == 'thumb.jpg' ? raise(CarrierWave::UploadError) : for_file
  end

  version :thumb, if: :img? do
    process :create_thumbnail

    def full_filename(for_file = model.clip.file)
      'thumb.jpg'
    end
  end

protected

  def img?(file)
    file.content_type =~ /jpe?g|gif|png|heic|pdf$/i
  end

  def create_thumbnail
    # time gm convert test.pdf -resize '300x300^' -gravity north -extent 300x300 -auto-orient -strip -quality 75 test-out.jpg

    manipulate! do |img|
      img.format('jpg') do |c|
        c.resize      '300x300^'
        c.gravity     'north'
        c.extent      '300x300'
        c.quality     '75'
        c.auto_orient
        c.strip
      end
      img
    end
  end

end

class Doc
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  DOCS = %w[doc docx dwg odb odf odg odp ods odt ppt pptx xls xlsx gz zip]
  IMGS = %w[jpg jpeg png gif heic pdf]

  embedded_in :memo

  mount_uploader :clip, ClipUploader, mount_on: :clipname

  def extension
    File.extname(clipname)[1..-1].try(:downcase)
  end

  def basename
    File.basename(clipname, '.*').try(:downcase)
  end

  def thumb?
    IMGS.include?(extension)
  end

  def icon?
    DOCS.include?(extension)
  end

  def expired?
    self.documentable.expired?
  end

  def thumbnail
    case
    when thumb? then clip.thumb.url
    when icon? then "icon_#{extension}.png"
    else ; 'icon_default.png'
    end
  end

end

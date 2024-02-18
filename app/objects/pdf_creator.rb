class PdfCreator
  def initialize(body_html:, pdf_path:, filename: , header:, options: {})
    @body_html, @pdf_path, @filename, @header, @pdf_options=body_html, pdf_path, filename, header, options
  end
  def call
    pdf = WickedPdf.new.pdf_from_string(body_html, pdf_default_options.merge(pdf_options))
    dir = "#{Rails.public_path}#{pdf_path}"
    save_path = Rails.root.join(dir, filename)

    unless File.directory? dir
      FileUtils.mkdir_p(dir)
    end
    if File.exists? save_path
      FileUtils.rm(save_path)
    end
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    "#{pdf_path}/#{filename}"
  end
  private
  def pdf_default_options
    {
       print_media_type: true,
       margin: { bottom: 15, top: 40, left: 10, right: 10 },
       encoding: "utf8",
       page_size: "A4",
       image_quality: 50,
       header: {
        spacing: 10,
        content: header, margin: { top: 10, bottom: 10 }
       }
    }
  end
  attr_reader :body_html, :pdf_path, :filename, :header, :pdf_options
end

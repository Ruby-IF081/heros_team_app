require 'render_anywhere'

class PdfGenerator
  include RenderAnywhere

  def initialize(company)
    @company = company
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/company.pdf")
  end

  def file_name
    "Company #{@company.name}.pdf"
  end

  private

  attr_reader :company

  def as_html
    render template: 'account/companies/pdf',
           layout: 'application_pdf',
           locals: { company: company }
  end
end

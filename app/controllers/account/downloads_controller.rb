class Account::DownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_company_pdf }
      format.html { render_sample_html } if Rails.env.development?
    end
  end

  private

  def company
    Company.find(params[:company_id])
  end

  def company_pdf
    PdfGenerator.new(company)
  end

  def send_company_pdf
    send_file company_pdf.to_pdf,
              filename: company_pdf.file_name,
              type: 'application/pdf',
              disposition: 'inline'
  end

  def render_sample_html
    render template: 'account/companies/pdf',
           layout: 'application_pdf',
           locals: { company: company }
  end
end

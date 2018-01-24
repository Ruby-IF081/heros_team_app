json.companies @companies do |company|
  json.call(company, :id, :name)
  json.url download_account_company_url(company, format: 'pdf')
end

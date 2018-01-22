json.companies @companies do |company|
  json.id company.id
  json.name company.name
  json.url download_account_company_url(company, format: 'pdf')
end

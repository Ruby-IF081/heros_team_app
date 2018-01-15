class NewCompanyWorker
  include Sidekiq::Worker

  def perform(id)
    puts "Company #{id} created!"

    BingApi::ClientSeven.new(company_id: id).pages_process
  end
end

class NewCompanyWorker
  include Sidekiq::Worker

  def perform(id)
    puts "Company #{id} created!"

    BingApiV7.new(Company.find_by(id: id)).pages_process
  end
end

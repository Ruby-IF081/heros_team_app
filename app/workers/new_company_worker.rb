class NewCompanyWorker
  include Sidekiq::Worker

  def perform(id)
    puts "Company #{id} created!"
  end
end

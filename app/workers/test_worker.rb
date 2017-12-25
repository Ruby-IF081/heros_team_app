class TestWorker
  include Sidekiq::Worker

  def perform
    puts "Hello from test worker!"
  end
end

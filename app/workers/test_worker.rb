class TestWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "Hello from test worker!"
  end
end

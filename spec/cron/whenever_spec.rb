require 'rails_helper'

describe 'Whenever Schedule' do
  before do
    load 'Rakefile'
  end

  it 'makes sure `rake` statements exist' do
    schedule = Whenever::Test::Schedule.new

    assert Rake::Task.task_defined?(schedule.jobs[:rake].first[:task])
  end
end

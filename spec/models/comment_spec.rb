require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }
  it 'has a valid factory' do
    expect(comment).to be_valid
    expect(comment.tenant). to eq(comment.user.tenant)
  end
end

# == Schema Information
#
# Table name: videos
#
#  id             :integer          not null, primary key
#  title          :string
#  embed_code     :text
#  videoable_id   :integer
#  videoable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Video < ApplicationRecord
  belongs_to :videoable, polymorphic: true

  validates :embed_code, presence: true
end

class Video < ApplicationRecord
  belongs_to :videoable, polymorphic: true
end

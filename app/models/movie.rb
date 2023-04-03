class Movie < ApplicationRecord
  validates :title, :youtube_id, presence: true

  belongs_to :user
end

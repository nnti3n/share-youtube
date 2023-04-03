class Movie < ApplicationRecord
  validates :title, :youtube_id, presence: true
end

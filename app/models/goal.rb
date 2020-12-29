class Goal < ApplicationRecord
  belongs_to :user

  validates :target_time, presence: true, numericality: true
end

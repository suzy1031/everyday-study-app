class Goal < ApplicationRecord
  belongs_to :user

  validates :target_time,
            presence: true,
            numericality: { greater_than: 0.1, less_than_or_equal_to: 168 },
            length: { in: 1..5 }

end

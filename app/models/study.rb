class Study < ApplicationRecord
  validates :time, presence: true, numericality: true
  validates :total, presence: true, numericality: true

  def self.this_week_total
    self.where(created_at: Date.today.beginning_of_week - 1..Date.today.end_of_week.end_of_day - 1.day).sum(:time)
  end
end

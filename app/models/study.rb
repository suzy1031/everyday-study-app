class Study < ApplicationRecord
  validates :time, presence: true, numericality: true
  validates :total, presence: true, numericality: true
end

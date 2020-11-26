class Study < ApplicationRecord
  validates :time, presence: true, numericality: true
  validates :total, presence: true, numericality: true

  def self.this_week_total
    @this_day = Date.today # 今日の日付
    @this_sunday = @this_day.beginning_of_week(:sunday) # 日曜日
    @this_saturday = @this_day.end_of_week(:sunday) # 土曜日
    # 日曜日を週の始まりをする為、日〜土のデータ取得
    self.where(created_at: @this_sunday..@this_saturday)
  end
end

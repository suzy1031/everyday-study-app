class Study < ApplicationRecord
  validates :time, presence: true, numericality: true
  validates :total, presence: true, numericality: true

  def self.this_week_total
    @this_day = Date.today # 今日の日付
    @this_date = @this_day.wday # 今日の曜日取得
    range = @this_day.all_week(:sunday) # 日曜日始まりで今週の日〜土を取得
    @data = Study.where(created_at: range) # 今週の日〜土のデータを取得

    # 今週チェック
    if (@this_date && @data.present?) # 今週の日〜月または今週のデータが1件以上の場合
      self.where(created_at: range) # 今週の日〜土のデータ取得
    else # 今週ではないかつ今週のデータが0件の場合
      self.order(created_at: :desc).limit(1) # 最新レコードを1件取得
    end
  end

end

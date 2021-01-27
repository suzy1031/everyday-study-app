class Study < ApplicationRecord
  belongs_to :user

  validates :time,
            presence: true,
            numericality: { less_than_or_equal_to: 24 }
  validates :total, presence: true, numericality: true

  # studies_controller #index
  def self.this_week_total
    @this_day = Time.now # 今日の日付
    @this_date = @this_day.wday # 今日の曜日取得
    @range = @this_day.all_week(:sunday) # 日曜日始まりで今週の日〜土を取得
    @data = Study.where(created_at: @range) # 今週の日〜土のデータを取得

    # 今週チェック
    if (@this_date && @data.present?) # 今週の日〜月または今週のデータが1件以上の場合
      self.where(created_at: @range) # 今週の日〜土のデータ取得
    else # 今週ではないかつ今週のデータが0件の場合
      self.order(created_at: :desc).limit(1) # 最新レコードを1件取得
    end
  end

  # studies_controller #histories
  def self.get_week_chart_data
    @this_day = Time.now
    @range = @this_day.all_week(:sunday)
    # 今週の日曜日~土曜日までの範囲
    # id, time日別合計値, user_id, created_at, 曜日(添字)を取得
    # 日別データ毎にグループ化する
    self.where(created_at: @range)
        .select(:id, "sum(time) as time", :user_id, :created_at, "dayofweek(created_at) - 1 as day_of_week")
        .group("date(created_at)")
  end

end

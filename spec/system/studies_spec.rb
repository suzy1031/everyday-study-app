require 'rails_helper'

RSpec.describe 'Record.vue system test', type: :system do
  before do
    @study = Study.create!(time: 1, total: 2)
  end
  it 'display success', js: true do
    visit root_path # study#indexページ
    expect(page).to have_css '.page-title' # 学習時間
    expect(page).to have_css '.page-sub-title' # 合計時間
    expect(page).to have_no_button 'register' # 登録ボタン非表示
    select '0:30', from: 'time' # 学習時間を選択
    expect(page).to have_button 'register' # 登録ボタン表示
    click_button 'register' # 登録ボタン押下
  end
end
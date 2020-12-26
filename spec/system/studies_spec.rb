require 'rails_helper'

RSpec.describe 'Record.vue system test', type: :system do
  # ユーザーを作成
  let(:user) { create(:user) }
  # todo 認証トークンを作成必要?
  def authenticated_header(user)
    # 機能しているか不明...
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    tokens = session.login
    token = tokens
    { 'Authorization': "Bearer #{token}" }
  end

  # ***system specでテストする内容***
  # 1. ルートパス'/signin'にアクセスし、ログイン処理を行う
  # 2. 認証成功した場合、'/record'へ遷移する
  # 3. 今週の学習時間が表示されている
  # 4. 合計時間が表示されている
  # 5. 登録ボタンが非表示
  # 6. セレクトボックスで学習時間を選択する
  # 7. 登録ボタンが活性化
  # 8. 登録ボタンを押下
  # 9. DBにデータが登録される
  # 10. カレントパスにリダイレクトされる
  # 11. 今週の学習時間が更新される
  # 12. 合計時間が更新される
  # 13. '/setting'に遷移する
  # 14. ログアウトボタン押下
  # 15. ログアウト処理成功
  # 16. ルートパス'/signin'にリダイレクトされる
  it 'is login action creates study and logout', js: true do
    visit root_path # signinページ
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    # todo 遷移しない Token is not foundエラー発生
    get '/record', headers: authenticated_header(user)
    visit '/record'

    expect(page).to have_css '.page-title' # 学習時間
    expect(page).to have_css '.page-sub-title' # 合計時間
    expect(page).to have_no_button 'register' # 登録ボタン非表示
    expect(page).to have_button 'register' # 登録ボタン表示
    expect {
      select '0:30', from: 'time' # 学習時間を選択
      click_button 'register' # 登録ボタン押下
    }. to change(Study, :count).by(1)
  end
end
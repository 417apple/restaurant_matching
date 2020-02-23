require 'rails_helper'

describe 'レストラン投稿機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = create(:user, name: 'ユーザーA', email: 'a@example.com',password:'aaaaaa',  password_confirmation:'aaaaaa')
      create(:restaurant, name: '最初のテスト店',user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'aaaaaa'
        click_button 'Log in'
      end

      it 'ユーザーAが作成したレストランが表示される' do
        expect(page).to have_content '最初のテスト店'
      end
    end
  end
end
require 'rails_helper'

describe 'レストラン投稿機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = create(:user)
      create(:restaurant)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'email', with: 'a@example.com'
        fill_in 'password', with: 'aaaaaa'
        click_button 'Log in'
      end

      it 'ユーザーAが作成したレストランが表示される' do
        expect(page).to have_content '最初の店名'
      end
    end
  end
end
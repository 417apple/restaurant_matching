require 'rails_helper'

describe 'レストラン投稿機能', type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com',password:'aaaaaa',  password_confirmation:'aaaaaa') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com',password:'bbbbbb',  password_confirmation:'bbbbbb') }
  let!(:restaurant_a) {create(:restaurant, name: '最初のテスト店',user: user_a)}


    before do
      visit new_user_session_path
      fill_in 'Email', with: 'a@example.com'
      fill_in 'Password', with: 'aaaaaa'
      click_button 'Log in'

      # create(:restaurant, name: '二つ目のテスト店',user: user_b)
      # visit new_user_session_path
      # fill_in 'Email', with: 'b@example.com'
      # fill_in 'Password', with: 'bbbbbb'
      # click_button 'Log in'
    end

    shared_examples_for 'ユーザーAとBが作成したレストランが表示される' do
      it { expect(page).to have_content '最初のテスト店' }
    end

    describe '一覧表示機能' do
      context 'ユーザーAがログインしているとき' do
        let(:login_user) { user_a }
        it_behaves_like 'ユーザーAとBが作成したレストランが表示される'
      end

      context 'ユーザーBがログインしているとき' do
        let(:login_user) { user_b }
        it_behaves_like 'ユーザーAとBが作成したレストランが表示される'
      end
    end

    # describe '詳細表示機能' do
    #   context 'ユーザーAがログインしているとき' do
    #     let(:login_user) { user_a }

    #     before do
    #       visit restaurant_path(restaurant_a)
    #     end

    #     it_behaves_like 'ユーザーAとBが作成したレストランが表示される'
    #   end
    # end


  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit  new_restaurant_path
      fill_in 'Name', with: restaurant_name
      click_button '投稿する'
    end

    context '新規作成画面で店名を入力したとき' do
      let(:restaurant_name) {'店名を入力する'}
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '店名を入力する'
      end
    end

    context '新規作成画面で店名を入力しなかったとき' do
      let(:restaurant_name) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '店名を入力してください'
        end
      end
    end
  end
end
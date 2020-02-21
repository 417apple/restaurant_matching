require 'rails_helper'

describe 'レストラン 投稿機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:restaurant_a) { FactoryBot.create(:task, name: '最初のレストラン投稿', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したレストランが表示される' do
    it { expect(page).to have_content '最初のレストラン投稿' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したレストランが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したレストランが表示されない' do
        expect(page).to have_no_content '最初のレストラン'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit restaurant_path(restaurant_a)
      end

      it_behaves_like 'ユーザーAが作成したレストランが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:restaurant_name) { '新規作成のテストを書く' } # デフォルトとして設定

    before do
      visit new_restaurant_path
      fill_in '名称', with: restaurant_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:restaurant_name) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end

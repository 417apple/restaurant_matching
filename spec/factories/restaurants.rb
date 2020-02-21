FactoryBot.define do
  factory :restaurant do
    name { 'テスト店' }
    comment { 'テストのコメントです' }
    user
    address {'テストの住所です'}
  end
end

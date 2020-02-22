FactoryBot.define do
  factory :restaurant do
    name { 'テスト店' }
    comment { 'テストのコメントです' }
    address {'テストの住所です'}
    user
  end
end

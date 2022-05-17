Fabricator(:card) do
  category { Fabricate :category, kind: 'cards' }
  name { Faker::Name.name }
  published_at { Time.now.utc }
  slug { "test-#{(rand*10000000000).to_i}" }
  num { (rand*10000000000).to_i }
end

Fabricator(:owner, from: :card) do
  user { Fabricate.build :user, role: 'owner' }
end
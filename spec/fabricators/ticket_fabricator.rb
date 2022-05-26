Fabricator(:ticket) do
  category { Fabricate :category, kind: 'tickets' }
  name { Faker::Name.name }
  slug { "test-#{(rand*10000000000).to_i}" }
  num { (rand*10000000000).to_i }
end

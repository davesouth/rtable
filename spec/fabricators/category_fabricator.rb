Fabricator(:category) do
  name { Faker::Name.name }
  slug { "test-#{(rand*10000000000).to_i}" }
  kind { 'cards' }
end

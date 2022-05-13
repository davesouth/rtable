Fabricator(:category) do
  name { Faker::Name.name }
  slug { Faker::Internet.domain_word }
  kind { 'card' }
end
Fabricator(:card) do
  category { Fabricate :category, kind: 'cards' }
  name { Faker::Name.name }
end

Fabricator(:owner, from: :card) do
  user { Fabricate.build :user, role: 'owner' }
end
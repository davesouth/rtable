json.extract! card, :id, :name, :slug, :kind, :created_at, :updated_at
json.url card_url(card, format: :json)

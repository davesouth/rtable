json.extract! ticket, :id, :name, :slug, :kind, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)

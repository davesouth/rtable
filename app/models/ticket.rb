class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps

  # Relations
  belongs_to :account

  # Schema
  field :name, type: String
  field :slug, type: String
  field :kind, type: String

  # Index
  index account_id: 1, slug: 1

  # Validations
  validates :name,
    presence: true
  validates :slug,
    presence: true

  # Override URL param
  def to_param
    slug
  end

end

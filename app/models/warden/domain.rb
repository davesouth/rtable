class Warden::Domain
  include Mongoid::Document
  include Mongoid::Timestamps

  # Constants
  RESERVED = %w[warden]

  # Field schema
  field :name, type: String
  field :slug, type: String

  # Index
  index slug: 1

  # Validations
  validates :name,
    presence: true
  validates :slug,
    presence: true,
    exclusion: RESERVED,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-z0-9-]+\z/,
      message: 'only allows lowercase letters, numbers and hyphens' }

end

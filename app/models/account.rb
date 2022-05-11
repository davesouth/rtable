class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  # Constants
  RESERVED = %w[warden]

  # Relations
  has_many :categories
  has_many :tickets

  # Schema
  field :slug, type: String
  field :name, type: String

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

  # Override URL for param
  def to_param
    slug
  end

end

class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  # Constants
  KINDS = %w[cards tickets]
  RESERVED = %w[tmp]

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
    presence: true,
    exclusion: RESERVED,
    uniqueness: {
      scope: 'account_id',
      case_sensitive: false },
    format: {
      with: /\A[a-z0-9-]+\z/,
      message: 'only allows lowercase letters, numbers and hyphens' }
  validates :kind,
    presence: true,
    inclusion: KINDS

  # Override URL param
  def to_param
    slug
  end

end

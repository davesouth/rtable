class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable

  # Constants
  KINDS = %w[cards tickets]

  # Schema
  field :name, type: String
  field :slug, type: String
  field :kind, type: String

  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: 'domain_id', case_sensitive: false }, format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }
  validates :kind, presence: true, inclusion: KINDS

  # Override URL param
  def to_param
    slug
  end

end

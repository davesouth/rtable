class Domain
  include Mongoid::Document
  include Mongoid::Timestamps

  # Thread safe class attribute to store current domain
  thread_mattr_accessor :current

  # Schema
  field :name, type: String
  field :slug, type: String

  # Index
  index slug: 1

  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }

  # Override URL for param
  def to_param
    slug
  end


end

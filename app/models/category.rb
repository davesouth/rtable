class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable

  # Type of models that use categories
  KINDS = %w[ cards tickets ].freeze
  # Reserve against allowing "tmp" slug
  RESERVED_SLUG = %w[ tmp ].freeze

  # Associations
  has_many :cards

  # Schema
  field :name, type: String
  field :kind, type: String
  field :slug, type: String

  # Validations
  validates :name, presence: true
  validates :kind, presence: true, inclusion: KINDS
  validates :slug, presence: true, exclusion: RESERVED_SLUG, uniqueness: { scope: 'domain_id', case_sensitive: false }, format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }

  # Scopes
  scope :cards, ->{ where(kind: 'cards') }

  # Override URL param
  def to_param
    slug
  end

end

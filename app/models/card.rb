class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable

  # Card name/title
  field :name, type: String

  ## Slug logic (to be extracted)

  # Select category
  belongs_to :category, optional: true

  # Initialize slug with random temporary id
  # Replace when published with generated id
  field :slug, type: String, default: ->{ "tmp-#{(rand*10000000000).to_i}" }
  # Increasing numerical ID suffix
  field :num, type: Integer, default: 0
  # Set published_at to make records public
  field :published_at, type: Time

  # Scopes
  scope :draft, ->{ where(published_at: nil) }
  scope :published, ->{ lt(published_at: Time.now.utc) }

  # Validations
  validates :slug, presence: true, uniqueness: { scope: 'domain_id', case_sensitive: false },format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }
  validates :name, presence: true, if: :published?
  validates :category, presence: true, if: :published?

  ## Class Methods

  # Create draft card
  def self.find_or_create_draft
    draft.first_or_create
  end

  ## Instance Methods

  # Override URL param
  def to_param
    slug
  end

  # Publication question
  def draft?
    published_at.blank?
  end

  def published?
    published_at.present?
  end

end

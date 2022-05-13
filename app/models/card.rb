class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable

  # Card name/title
  field :name, type: String


  # Initialize slug with random temporary id
  # Replace when published with generated id
  field :slug, type: String, default: ->{ "tmp-#{(rand*10000000000).to_i}" }
  # Increasing numerical ID suffix
  field :num, type: Integer, default: 0
  # Set published_at to make records public
  field :published_at, type: Time

  # Scopes
  scope :unpublished, ->{ where(published_at: nil) }
  scope :published, ->{ gt(published_at: Time.now.utc) }

  # Publication question
  def unpublished?
    published_at.blank?
  end

  # Override URL param
  def to_param
    slug
  end

  ## Class Methods

  # Create unpublished card
  def self.find_or_create_unpublished
    unpublished.first_or_create
  end

  # Find or create unpublished record

  # Validations
  # validates :name, presence: true

  # validates :slug, presence: true, uniqueness: { scope: 'domain_id', case_sensitive: false },format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }

end

module Sluggable
  extend ActiveSupport::Concern

  included do
    # Select category
    belongs_to :category, optional: true

    # Always have a name
    field :name, type: String

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

    # Always validate slug
    validates :slug,
      presence: true,
      uniqueness: { scope: 'domain_id', case_sensitive: false },
      format: { with: /\A[a-z0-9-]+\z/, message: 'only allows lowercase letters, numbers and hyphens' }

    # Validations when record is published
    validates :name, presence: true, if: :published?
    validates :category, presence: true, if: :published?

    # Add most common individual index
    index domain_id: 1, slug: 1
    # Add most common list index
    index domain_id: 1, published_at: 1

  end

  class_methods do
    # Create draft card
    def find_or_create_draft
      draft.first_or_create
    end
  end

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

  def publish!(params)
    update!(params.merge(published_at: Time.now.utc))
  end

  def slugify!
    update!(category.slugify_hash)
  end
end

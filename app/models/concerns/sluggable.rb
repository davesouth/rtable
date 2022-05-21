module Sluggable
  extend ActiveSupport::Concern

  included do
    # Set slug before validation
    before_validation :set_slug, on: :create

    # Select category
    belongs_to :category

    # Always have a name
    field :name, type: String
    # Generate plug from category and num (on create)
    field :slug, type: String
    # Increasing numerical ID suffix
    field :num, type: Integer, default: 0

    # Validations
    validates :name, presence: true
    validates :slug,
      presence: true,
      uniqueness: { scope: 'domain_id', case_sensitive: false },
      format: { with: /\A[a-z0-9-]+\z/, message: 'only lowercase letters, numbers and hyphens' }

    # Add most common individual index
    index domain_id: 1, slug: 1

  end

  # Override URL param
  def to_param
    slug
  end

  def set_slug
    if category_id.present?
      self.num = category.next_num
      self.slug = category.slugify
    end
  end ; private :set_slug

end

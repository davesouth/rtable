class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable

  ROLES = %w[ owner staff guest blocked ].freeze

  # Primary email (auth and notification emails)
  field :email, type: String
  # Card role on system
  field :role, type: String, default: 'guest'

  validates :role, presence: true, inclusion: ROLES
  validates :email,
    allow_blank: true,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { scope: 'domain_id', case_sensitive: false }

  # Quick lookup of primary email for authentication
  index domain_id: 1, email: 1

end

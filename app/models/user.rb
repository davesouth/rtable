class User
  include Mongoid::Document

  # Allowed roles
  ROLES = %w[ owner staff blocked ].freeze

  # Associations
  embedded_in :card

  # Generate nonce token
  field :role, type: String

  # Ensure role is allowed
  validates :role, presence: true, inclusion: ROLES

end
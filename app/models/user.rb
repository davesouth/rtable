class User
  include Mongoid::Document

  # Thread safe class attribute to store current user
  thread_mattr_accessor :current

  # Allowed roles
  ROLES = %w[ owner staff blocked ].freeze

  # Associations
  embedded_in :card

  # Generate nonce token
  field :role, type: String

  # Ensure role is allowed
  validates :role, presence: true, inclusion: ROLES

end

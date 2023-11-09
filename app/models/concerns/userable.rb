module Userable
  extend ActiveSupport::Concern

  included do

    # Associations
    embeds_one :user
    embeds_one :auth

    # Primary email (auth and notification emails)
    field :email, type: String

    validates :email,
      allow_blank: true,
      format: { with: URI::MailTo::EMAIL_REGEXP },
      uniqueness: { scope: 'domain_id', case_sensitive: false }

    # Quick lookup of primary email for authentication
    index domain_id: 1, email: 1

  end

  # Get role if it exists or return guest
  def role
    has_user? ? user.role : 'guest'
  end

end

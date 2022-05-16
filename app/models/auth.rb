class Auth
  include Mongoid::Document

  # Associations
  embedded_in :card

  # Generate nonce token
  field :token, type: String, default: ->{ SecureRandom.base58(16) }
  # Set expiration time
  field :expired_at, type: Time, default: ->{ 10.minutes.from_now }

  def params
    { user_id: self.card.id.to_s, token: self.token }
  end

  def validate(token_param)
    token_param == token && Time.now.utc < expired_at
  end

end
class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
  include Userable
  include Authorable

  # Card as author assocations
  has_many :tickets, inverse_of: 'author'
  has_many :cards, inverse_of: 'author'

end

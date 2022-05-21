class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
  include Authable

  # A card is the author of many tickets and cards
  has_many :tickets, inverse_of: 'author'
  has_many :cards, inverse_of: 'author'

  # Set author
  before_create :set_author

  # A card is authored by another card
  belongs_to :author, class_name: 'Card', inverse_of: 'cards', optional: true

  # Save current_user as author if it exists
  def set_author
    self[:author_id] = User.current.id if User.current
  end

end

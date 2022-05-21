class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable

  # Set author
  before_create :set_author

  # Author card
  belongs_to :author, class_name: 'Card', inverse_of: 'tickets', optional: true

  # Save current_user as author if it exists
  def set_author
    self[:author_id] = User.current.id
  end

end

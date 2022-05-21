module Authorable
  extend ActiveSupport::Concern

  included do
    # Callback to set author
    before_create :set_author

    # Author card
    belongs_to :author, class_name: 'Card', optional: true

    # Save current_user as author if it exists (optional)
    def set_author
      self.author_id = User.current.id if User.current
    end ; private :set_author
  end

end

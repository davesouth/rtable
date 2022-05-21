class Memo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authorable

  # Base class for all items on a ticket feed
  embedded_in :ticket

  # Main body
  field :body, type: String
end

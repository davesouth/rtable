class Memo
  include Mongoid::Document
  include Authorable

  # Base class for all items on a ticket feed
  embedded_in :ticket
end

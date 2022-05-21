class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
  include Authorable

  embeds_many :memos
end

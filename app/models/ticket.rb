class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
  include Authorable
end

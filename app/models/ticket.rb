class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Domainable
  include Sluggable
end

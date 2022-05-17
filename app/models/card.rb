class Card
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Domainable
  include Sluggable
  include Authable
end

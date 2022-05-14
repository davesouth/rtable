class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
end

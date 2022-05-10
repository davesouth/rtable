class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  # Relations
  belongs_to :account

  # Field schema
  field :name, type: String
  field :slug, type: String

end

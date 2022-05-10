class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  # Relations
  belongs_to :account

  # Field schema
  field :name, type: String
  field :slug, type: String

  # Override URL param
  def to_param
    slug
  end

end

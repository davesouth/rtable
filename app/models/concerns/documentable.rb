module Documentable
  extend ActiveSupport::Concern

  included do
    embeds_many :docs
  end

  def expired?
    false
  end

  def has_highlight?
    docs.present?
  end

  def highlight
    docs.first
  end

end

class Memo
  include Mongoid::Document
  include Authorable
  include Documentable

  # Base class for all items on a ticket feed
  embedded_in :ticket

  # Memos are draft until published
  field :published_at, type: Time

  # Published and draft scopes
  scope :published, ->{ lt(published_at: Time.current).asc(:published_at) }
  scope :draft, ->{ unscoped.where(published_at: nil) }

private

  def set_published_at
    self.published_at = Time.current
  end

end

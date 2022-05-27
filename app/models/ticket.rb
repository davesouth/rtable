class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  include Domainable
  include Sluggable
  include Authorable

  # Base memo relationship for ticket stream
  embeds_many :memos

  ## Closure logic

  # Set time the ticket is last closed (use memos for close history)
  field :closed_at, type: Time

  # Scope for open/closed tickets
  scope :open, ->{ where(closed_at: nil) }
  scope :closed, ->{ lt(closed_at: Time.current) }

  # State?
  def state
    open? ? 'open' : 'closed'
  end

  def open?
    closed_at.blank?
  end

  def closed?
    closed_at.present?
  end


  ## Memo logic
  def draft_note
    first_draft_by_author('Note') || self.memos.create({}, Note)
  end

private

  def first_draft_by_author(type)
    self.memos.draft.where('_type' => type, author_id: User.current.id).first
  end

end

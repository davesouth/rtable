class TicketReopen < Memo
  after_build :set_published_at
end

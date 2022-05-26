class TicketReopen < Memo
  field :reopened_at, type: Time, default: ->{ Time.current }
end

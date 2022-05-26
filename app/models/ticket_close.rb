class TicketClose < Memo
  field :closed_at, type: Time, default: ->{ Time.current }
end

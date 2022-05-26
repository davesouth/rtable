class TicketChange < Memo
  after_build :set_changes
  field :name, type: String
  field :old_name, type: String

  private

    def set_changes
      if name != ticket.name
        self.old_name = ticket.name
      end
    end
end

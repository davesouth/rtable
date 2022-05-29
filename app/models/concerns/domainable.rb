module Domainable
  extend ActiveSupport::Concern

  included do
    # Domain defined in app.yml with Integer ID
    field :domain_id, type: Integer, default: ->{ Domain.current.id }

    # Default scope as domain id
    default_scope ->{ where(domain_id: Domain.current.id) }

    # Ensure model has domain_id
    validates :domain_id, presence: true, numericality: true
  end

end

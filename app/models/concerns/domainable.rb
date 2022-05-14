module Domainable
  extend ActiveSupport::Concern

  included do
    # Add belongs_to relationship for model.domain methods
    belongs_to :domain

    # Scope all model requests model by current domain id
    default_scope ->{ where(domain_id: Domain.current.id) }
  end

end

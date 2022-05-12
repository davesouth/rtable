module Domainable
  extend ActiveSupport::Concern

  included do
    # Add belongs_to relationship for model.domain methods
    belongs_to :domain

    # Scope all model requests model by current domain id
    default_scope ->{ where(domain_id: Domain.current.id) }

    # Add most common index of domain and slug
    index domain_id: 1, slug: 1
  end

end

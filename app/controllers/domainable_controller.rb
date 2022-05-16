class DomainableController < ApplicationController

  # Scope current domain around request
  around_action :set_current_domain

  # Find current_domain from subdomain
  def current_domain
    Domain.find_by slug: request.subdomain
  end ; helper_method :current_domain

  # Find and save current domain
  def set_current_domain
    Domain.current = current_domain
    yield
  rescue ActionController::RoutingError
    respond_to { |f| f.any { head :bad_request } }
  ensure
    Domain.current = nil
  end ; private :set_current_domain

end

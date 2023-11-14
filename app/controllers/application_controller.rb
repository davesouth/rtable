class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  # Scope current domain
  around_action :scope_current

  def current_domain
    Domain.find_by_host(request.host.downcase)
  end ; helper_method :current_domain

  def scope_current
    Domain.current = current_domain
    yield
  rescue ActionController::RoutingError
    respond_to { |f| f.any { head :bad_request } }
  ensure
    Domain.current = nil
  end ; private :scope_current

end

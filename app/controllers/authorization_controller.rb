class AuthorizationController < DomainableController
  include CanCan::ControllerAdditions

  # Always check authorization!
  check_authorization

  # Set current user for every request
  before_action :require_user

  # Set current user card
  def current_user
    @current_user ||= Card.find(session[:user_id]) if session[:user_id]
  end ; helper_method :current_user

  # Set current user or forward to login
  def require_user
    if current_user.blank?
      # Save current page for redirect after login
      session['redirect_path'] = url_for(request.params)
      # Redirect to login page
      redirect_to new_session_path
    end
  end ; private :require_user

end

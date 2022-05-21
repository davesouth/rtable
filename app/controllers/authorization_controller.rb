class AuthorizationController < DomainableController
  include CanCan::ControllerAdditions

  # Always check authorization!
  check_authorization

  # Set current user for every request
  around_action :set_current_user

  # Set current user card
  def current_user
    @current_user ||= Card.find(session[:user_id]) if session[:user_id]
  rescue Mongoid::Errors::DocumentNotFound
    save_path_and_redirect_to_login
  end ; helper_method :current_user

  # Set current user or forward to login
  def set_current_user
    User.current = current_user
    yield
  rescue CanCan::AccessDenied
    save_path_and_redirect_to_login
  ensure
    User.current = nil
  end ; private :set_current_user

  def save_path_and_redirect_to_login
    # Save current page for redirect after login
    session['redirect_path'] = url_for(request.params)
    # Redirect to login page
    redirect_to(new_session_path) and return
  end
end

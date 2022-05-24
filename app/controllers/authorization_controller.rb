class AuthorizationController < DomainableController
  include CanCan::ControllerAdditions

  # Always check authorization!
  check_authorization

  # Set current user for every request
  around_action :set_current_user

  # Set current user card
  def current_user
    @current_user ||= Card.find(session[:user_id]) if session[:user_id]
  end ; helper_method :current_user

  # Set current user or forward to login
  def set_current_user
    User.current = current_user
    yield
  rescue CanCan::AccessDenied
    # Save current page for redirect after login
    session['redirect_path'] = url_for(request.params)

    if current_user.blank?
      # Please log in to access resource
      render 'sessions/unauthorized', status: :unauthorized, layout: 'auth'
    else
      # Forbidden resource for logged in user
      render 'sessions/forbidden', status: :forbidden, layout: 'auth'
    end

  ensure
    User.current = nil
  end ; private :set_current_user

end

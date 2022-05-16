class SessionsController < DomainableController
  before_action :redirect_logged_in_user, only: [:new, :auth]

  def new
    render :new, layout: 'auth'
  end

  def create
    # Bots fill out invisible confirm_email field
    raise(ArgumentError, 'Login honey trap.') if params[:confirm_email].present?

    # Find the user's card
    @user = Card.find_by email: sanitized_email

    # Remove auth token if it exists
    destroy_auth

    # Create a new auth token
    @user.create_auth

    SessionMailer.magic(email: @user.email, lnk: auth_session_url(@user.auth.params)).deliver_now

    # Log request
    tally('Login request')

    # Show user successful request screen
    render :create, layout: 'auth'

  rescue Mongoid::Errors::DocumentNotFound
    tally('UNKNOWN EMAIL')
    redirect_to new_session_url(error: 'Nope! Try Again.', email: sanitized_email)
  end

  def auth
    # Remember where to redirect after logging in
    redirect_path = session[:redirect_path]

    # Erase the session cookie
    reset_session

    # Find the user's card
    @user = Card.find params[:user_id]

    # Validate token
    if @user.auth.validate(params[:token])
      destroy_auth
      session['user_id'] = @user.id.to_s
      tally('Authenticated user')
      redirect_to (redirect_path || root_url)
    else
      destroy_auth
      tally('Invalid or expired key request')
      redirect_to new_session_url(error: 'Invalid or expired key.', email: @user.email)
    end
  end

  def destroy
    tally('Logout')
    reset_session
    redirect_to new_session_url
  end

  private

    def redirect_logged_in_user
      if session[:user_id].present?
        redirect_to (session[:redirect_path] || root_url)
      end
    end

    def sanitized_email
      if params[:email].match(URI::MailTo::EMAIL_REGEXP)
        return params[:email]
      else
        raise ArgumentError, 'Invalid email'
      end
    end

    def destroy_auth
      @user.auth.destroy if @user.has_auth?
    end

    def tally(act)
      logger.info "TALLY: #{act} from #{request.remote_ip} IP address using [#{request.user_agent}] browser with [#{tally_email}] address."
    end

    def tally_email
      if @user
        @user.email
      elsif session[:user_id].present?
        session[:user_id]
      else
        params[:email].present? ? sanitized_email : 'unavailable'
      end
    end

end
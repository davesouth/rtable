class DashboardController < AuthorizationController

  def index
    authorize! :read, Card
  end

end

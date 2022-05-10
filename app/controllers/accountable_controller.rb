class AccountableController < ApplicationController
  before_action :set_account

  # Set account for all inherited controllers
  def set_account
    @account = Account.find_by slug: params[:account_id]
  end ; private :set_account

end

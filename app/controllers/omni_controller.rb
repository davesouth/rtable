class OmniController < ApplicationController

  layout 'omni'

  before_action :require_user

end

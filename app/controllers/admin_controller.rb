class AdminController < ApplicationController

  # Basic authentication for Omni administration section
  # Set basic_user and basic_pass in rails credentials:edit
  http_basic_authenticate_with name: Rails.application.credentials.basic_user, password: Rails.application.credentials.basic_pass

  # Use generic admin layout
  layout 'admin'

end

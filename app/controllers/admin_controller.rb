class AdminController < ApplicationController

  # Basic authentication for administration section
  # Set admin_user and admin_pass in rails credentials:edit
  http_basic_authenticate_with(
    name: Rails.application.credentials.admin_user,
    password: Rails.application.credentials.admin_pass)

  # Use generic admin layout
  layout 'admin'

end

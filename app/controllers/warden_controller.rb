class WardenController < ApplicationController

  # Basic authentication for Warden administration section
  # Set basic_user and basic_pass in rails credentials:edit
  http_basic_authenticate_with(
    name: Rails.application.credentials.basic_user,
    password: Rails.application.credentials.basic_pass
  )

  # Use generic warden layout
  layout 'warden'

end

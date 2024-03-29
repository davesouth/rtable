# Load application site domains
App = ActiveSupport::HashWithIndifferentAccess.new(Rails.application.config_for(:app))

Rails.application.configure do
  config.hosts = App[:domains].keys
end

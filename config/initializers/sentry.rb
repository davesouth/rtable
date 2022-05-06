Sentry.init do |config|

  # Configure application credentials on sentry.io
  config.dsn = Rails.application.credentials.sentry_dsn
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Only in production (it's annoying in development)
  config.enabled_environments = %w[production]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  # config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
    # true
  # end
end

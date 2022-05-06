Sentry.init do |config|

  # Sentry is annoying in development mode
  if Rails.env.production?
    config.dsn = Rails.application.credentials.sentry_dsn
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # Filter out confidential parameters
    filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
    config.before_send = lambda do |event, hint|
      filter.filter(event.to_hash)
    end

    # Set tracesSampleRate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production
    # config.traces_sample_rate = 1.0
    # or
    # config.traces_sampler = lambda do |context|
      # true
    # end
  end
end

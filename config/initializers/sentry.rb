# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = "https://fe8c071303d44f766fafedef4677881c@o4510908679454720.ingest.de.sentry.io/4510908693086288"
  config.breadcrumbs_logger = [ :active_support_logger ]
  config.send_default_pii = true
  config.environment = Rails.env
  # config.traces_sample_rate = 1.0
end

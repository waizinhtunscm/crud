# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins ENV['ALLOWED_ORIGINS']
  
      resource '*',
              headers: :any,
              methods: %i[get post put patch delete options head],
              expose: %w[Per-Page Total Link]
    end
  end
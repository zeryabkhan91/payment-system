# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # allows use of dom_id()
  config.include ActionView::RecordIdentifier, type: :system
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
  # config.include AuthenticationTestHelpers::SystemHelpers, type: :system

  Capybara.configure do |capybara_config|
    capybara_config.server_port = 4000
  end

  # This is for our tests as a Broadcaster
  Capybara.register_driver(:headless_browser) do |app|
    options = %w[
      disable-popup-blocking
      disable-translate
      test-type
      headless
    ]

    options_obj = Selenium::WebDriver::Chrome::Options.new(args: options)
    options_obj.add_preference(
      'profile.content_settings.exceptions.clipboard',
      {
        '*': { setting: 1 }
      }
    )
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options_obj
    )
  end

  #  This is for when we are debugging
  Capybara.register_driver(:debug_browser) do |app|
    options = %w[
      disable-popup-blocking
      disable-translate
      auto-open-devtools-for-tabs
      test-type
      window-size=2400,2400
    ]

    options_obj = Selenium::WebDriver::Chrome::Options.new(args: options)
    options_obj.add_preference(
      'profile.content_settings.exceptions.clipboard',
      {
        '*': { setting: 1 }
      }
    )
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options_obj
    )
  end

  config.before(:example, type: :system) do
    # if ENV.fetch('RUBYIDE', nil) =~ /rubys-debug-browser/
    #   driven_by :debug_browser
    # else
    driven_by :headless_browser
    # end
  end
end

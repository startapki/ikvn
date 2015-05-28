require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ikvn
  class Application < Rails::Application
    config.time_zone = 'UTC'

    config.i18n.default_locale = :ru

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.to_prepare do
      Devise::SessionsController.layout      'devise'
      Devise::RegistrationsController.layout 'devise'
      Devise::ConfirmationsController.layout 'devise'
      Devise::UnlocksController.layout       'devise'
      Devise::PasswordsController.layout     'devise'

      Devise::Mailer.layout 'mail'
    end
  end
end

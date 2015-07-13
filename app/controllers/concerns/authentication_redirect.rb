module AuthenticationRedirect
  extend ActiveSupport::Concern

  included do
    before_action :store_location
  end

  DEVISE_PATHS = [
    '/users/sign_in',
    '/users/sign_up',
    '/users/sign_out',
    '/users/password/new',
    '/users/password/edit',
    '/users/confirmation'
  ].freeze

  private

  def devise_path?(path)
    DEVISE_PATHS.include?(path)
  end

  def store_location
    return if !request.get? || request.xhr?
    return if devise_path?(request.path)

    session[:previous_url] = request.fullpath
  end

  def after_sign_in_path_for(_resource)
    session[:previous_url] || root_path
  end
end

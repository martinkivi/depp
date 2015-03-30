module Depp
  # class ApplicationController < ::ApplicationController
  class ApplicationController < ActionController::Base
    include CurrentUserHelper
    include ApplicationHelper

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    helper_method :depp_current_user

    rescue_from(Errno::ECONNRESET, Errno::ECONNREFUSED) do |exception|
      redirect_to login_url, alert: t(:no_connection_to_registry)
    end

    def depp_current_user
      @depp_current_user ||= Depp::User.new(
        tag: current_user.username,
        password: current_user.password
      )
    end

    def response_ok?
      @data.css('result').each do |x|
        success_codes = %(1000, 1300, 1301)
        return false unless success_codes.include?(x['code'])
      end
      true
    end
  end
end

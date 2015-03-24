module Depp
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate_user

    helper_method :current_user

    rescue_from(Errno::ECONNRESET, Errno::ECONNREFUSED) do |exception|
      redirect_to login_pki_url, alert: t(:no_connection_to_registry)
    end

    def authenticate_user
      redirect_to login_pki_path and return unless current_user && session[:last_seen]

      if (session[:last_seen].to_i + ENV['session_timeout'].to_i) < Time.now.to_i
        session_timeout
      else
        session[:last_seen] = Time.now.to_i
      end
    end

    def session_timeout
      reset_session
      flash[:alert] = t('your_session_has_timed_out')
      redirect_to login_pki_path and return
    end

    def current_user
      return if !session[:tag] || !session[:password]

      @user_cache ||= Depp::User.new(
        tag: session[:tag],
        password: session[:password],
        pki: session[:pki]
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

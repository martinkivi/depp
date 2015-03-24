module Depp
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user
    layout 'depp/login'

    # rubocop: disable Metrics/PerceivedComplexity
    # rubocop: disable Metrics/CyclomaticComplexity
    def create
      @user = Depp::User.new(params[:user].merge(
          pki: request.env['HTTP_SSL_CLIENT_S_DN_CN'].present?
        )
      )

      if @user.pki && request.env['HTTP_SSL_CLIENT_S_DN_CN'] != params[:user][:tag]
        @user.errors.add(:base, :invalid_cert)
      end

      if @user.errors.none? && @user.valid?
        session[:tag] = params[:user][:tag]
        session[:password] = params[:user][:password]
        session[:last_seen] = Time.now.to_i
        session[:pki] = @user.pki

        redirect_to root_path
      else
        render 'login_pki'
      end
    end
    # rubocop: enable Metrics/PerceivedComplexity
    # rubocop: enable Metrics/CyclomaticComplexity

    def pki
      create
    end

    def destroy
      reset_session
      redirect_to login_pki_path
    end

    def login
      @user = Depp::User.new
    end

    def login_pki
      @user = Depp::User.new
    end
  end
end

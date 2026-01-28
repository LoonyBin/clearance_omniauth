module ClearanceOmniauth
  class AuthenticationsController < ApplicationController
    # OmniAuth 2.x sends POST requests for callbacks
    skip_before_action :verify_authenticity_token, only: [:create]

    def index
      @authentications = current_user.authentications if current_user
    end

    def create
      omniauth = request.env["omniauth.auth"]

      if omniauth.blank?
        flash[:alert] = "Authentication failed. Please try again."
        redirect_to Configuration.login_failure_url and return
      end

      authentication = Authentication.find_by(provider: omniauth["provider"], uid: omniauth["uid"])

      if authentication
        handle_existing_authentication(authentication, omniauth)
      elsif current_user
        link_authentication_to_current_user(omniauth)
      else
        create_new_user_from_omniauth(omniauth)
      end
    end

    def destroy
      @authentication = current_user.authentications.find(params[:id])
      @authentication.destroy
      flash[:notice] = "Successfully destroyed authentication."
      redirect_to authentications_url
    end

    def failure
      flash[:alert] = "Authentication failed: #{params[:message].humanize}"
      redirect_to Configuration.login_failure_url
    end

    private

    def handle_existing_authentication(authentication, omniauth)
      user = authentication.user
      sign_in user
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        redirect_to Configuration.after_login_url
      else
        flash[:alert] = "There is an issue signing you in."
        flash[:notice] = user.errors.full_messages.to_sentence
        redirect_to Configuration.login_failure_url
      end
    end

    def link_authentication_to_current_user(omniauth)
      current_user.authentications.create(provider: omniauth["provider"], uid: omniauth["uid"])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    end

    def create_new_user_from_omniauth(omniauth)
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in user
        redirect_to Configuration.after_login_url
      else
        flash[:alert] = "There is an issue signing you up."
        session[:omniauth] = omniauth.except("extra")
        flash[:notice] = user.errors.full_messages.to_sentence
        redirect_to Configuration.login_failure_url
      end
    end
  end
end

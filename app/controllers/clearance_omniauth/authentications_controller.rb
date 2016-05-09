module ClearanceOmniauth
  class AuthenticationsController < ApplicationController
    def index
      @authentications = current_user.authentications if current_user
    end

    def create
      omniauth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        user = authentication.user
        sign_in user
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "Signed in successfully."
          redirect_to Configuration.after_login_url
        else
          flash[:alert] = "There is an issue signing you in."
          flash[:notice] = user.errors
          redirect_to Configuration.login_failure_url
        end
      elsif current_user
        current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:notice] = "Authentication successful."
        redirect_to authentications_url
      else
        user = User.new
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "Signed in successfully."
          sign_in user
          redirect_to Configuration.after_login_url
        else
          flash[:alert] = "There is an issue signing you up."
          session[:omniauth] = omniauth.except('extra')
          flash[:notice] = user.errors 
          redirect_to Configuration.login_failure_url
        end
      end
    end

    def destroy
      @authentication = current_user.authentications.find(params[:id])
      @authentication.destroy
      flash[:notice] = "Successfully destroyed authentication."
      redirect_to authentications_url
    end
  end
end

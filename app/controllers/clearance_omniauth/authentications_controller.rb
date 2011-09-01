module ClearanceOmniauth
  class AuthenticationsController < ApplicationController
    def index
      @authentications = current_user.authentications if current_user
    end

    def create
      omniauth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        flash[:notice] = "Signed in successfully."
        sign_in authentication.user
        redirect_back_or "/"
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
          redirect_back_or "/"
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to sign_up_url
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

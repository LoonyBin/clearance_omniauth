module ClearanceOmniauth
  class UsersController < Clearance::UsersController
    def create
      @user = ::User.new(params[:user])
      @user.apply_omniauth(session[:omniauth]) if session[:omniauth]
      if @user.save
        session[:omniauth] = nil
        sign_in(@user)
        redirect_back_or(url_after_create)
      else
        flash_failure_after_create
        render :template => 'users/new'
      end
    end
  end
end

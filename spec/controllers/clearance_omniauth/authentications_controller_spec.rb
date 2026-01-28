require "rails_helper"

RSpec.describe ClearanceOmniauth::AuthenticationsController, type: :controller do
  routes { ClearanceOmniauth::Engine.routes }

  let(:user) { create(:user) }

  def mock_omniauth(provider: "twitter", uid: "12345", email: "test@example.com")
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(
      provider: provider,
      uid: uid,
      info: { email: email }
    )
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider.to_sym]
  end

  describe "GET #index" do
    context "when user is signed in" do
      before { sign_in_as(user) }

      it "assigns user's authentications" do
        authentication = create(:authentication, user: user)
        get :index
        expect(assigns(:authentications)).to eq([authentication])
      end
    end

    context "when user is not signed in" do
      it "assigns nil to authentications" do
        get :index
        expect(assigns(:authentications)).to be_nil
      end
    end
  end

  describe "POST #create" do
    context "with existing authentication" do
      let!(:authentication) { create(:authentication, user: user, provider: "twitter", uid: "12345") }

      before { mock_omniauth(provider: "twitter", uid: "12345") }

      it "signs in the user" do
        post :create, params: { provider: "twitter" }
        expect(controller.current_user).to eq(user)
      end

      it "redirects to after_login_url" do
        post :create, params: { provider: "twitter" }
        expect(response).to redirect_to(ClearanceOmniauth::Configuration.after_login_url)
      end
    end

    context "when user is signed in and adding new provider" do
      before do
        sign_in_as(user)
        mock_omniauth(provider: "facebook", uid: "67890")
      end

      it "creates a new authentication for the current user" do
        expect {
          post :create, params: { provider: "facebook" }
        }.to change(ClearanceOmniauth::Authentication, :count).by(1)
      end

      it "redirects to authentications index" do
        post :create, params: { provider: "facebook" }
        expect(response).to redirect_to(authentications_url)
      end
    end

    context "with new user via OAuth" do
      before { mock_omniauth(provider: "twitter", uid: "new_user_123", email: "newuser@example.com") }

      it "creates a new user" do
        expect {
          post :create, params: { provider: "twitter" }
        }.to change(User, :count).by(1)
      end

      it "signs in the new user" do
        post :create, params: { provider: "twitter" }
        expect(controller.current_user).to be_present
      end
    end

    context "when omniauth data is blank" do
      before { request.env["omniauth.auth"] = nil }

      it "redirects to login_failure_url" do
        post :create, params: { provider: "twitter" }
        expect(response).to redirect_to(ClearanceOmniauth::Configuration.login_failure_url)
      end
    end
  end

  describe "DELETE #destroy" do
    before { sign_in_as(user) }

    let!(:authentication) { create(:authentication, user: user) }

    it "destroys the authentication" do
      expect {
        delete :destroy, params: { id: authentication.id }
      }.to change(ClearanceOmniauth::Authentication, :count).by(-1)
    end

    it "redirects to authentications index" do
      delete :destroy, params: { id: authentication.id }
      expect(response).to redirect_to(authentications_url)
    end
  end

  describe "GET #failure" do
    it "sets flash alert with error message" do
      get :failure, params: { message: "access_denied" }
      expect(flash[:alert]).to include("Access denied")
    end

    it "redirects to login_failure_url" do
      get :failure, params: { message: "access_denied" }
      expect(response).to redirect_to(ClearanceOmniauth::Configuration.login_failure_url)
    end
  end
end

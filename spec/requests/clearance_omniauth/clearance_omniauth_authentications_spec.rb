require "rails_helper"

RSpec.describe "ClearanceOmniauth::Authentications", type: :request do
  describe "GET /auth/authentications" do
    it "returns a successful response" do
      get clearance_omniauth.authentications_path
      expect(response).to have_http_status(:success)
    end
  end
end

require "rails_helper"

RSpec.describe ClearanceOmniauth::AuthenticationsController, type: :routing do
  routes { ClearanceOmniauth::Engine.routes }

  describe "routing" do
    it "routes GET /:provider/callback to #create" do
      expect(get: "/twitter/callback").to route_to(
        controller: "clearance_omniauth/authentications",
        action: "create",
        provider: "twitter"
      )
    end

    it "routes POST /:provider/callback to #create" do
      expect(post: "/twitter/callback").to route_to(
        controller: "clearance_omniauth/authentications",
        action: "create",
        provider: "twitter"
      )
    end

    it "routes GET /failure to #failure" do
      expect(get: "/failure").to route_to(
        controller: "clearance_omniauth/authentications",
        action: "failure"
      )
    end

    it "routes GET /authentications to #index" do
      expect(get: "/authentications").to route_to(
        controller: "clearance_omniauth/authentications",
        action: "index"
      )
    end

    it "routes DELETE /authentications/:id to #destroy" do
      expect(delete: "/authentications/1").to route_to(
        controller: "clearance_omniauth/authentications",
        action: "destroy",
        id: "1"
      )
    end
  end
end

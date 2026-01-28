require "rails_helper"

RSpec.describe ClearanceOmniauth::Authentication, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    subject { build(:authentication) }

    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe "#provider_name" do
    it "returns OpenID for open_id provider" do
      authentication = build(:authentication, provider: "open_id")
      expect(authentication.provider_name).to eq("OpenID")
    end

    it "returns titleized provider name for other providers" do
      authentication = build(:authentication, provider: "twitter")
      expect(authentication.provider_name).to eq("Twitter")
    end
  end
end

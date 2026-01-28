require "rails_helper"

RSpec.describe "clearance_omniauth/authentications/index", type: :view do
  before do
    assign(:authentications, [
      build(:authentication, provider: "twitter", uid: "123"),
      build(:authentication, provider: "facebook", uid: "456")
    ])
  end

  it "renders a list of authentications" do
    render

    expect(rendered).to include("Twitter")
    expect(rendered).to include("Facebook")
  end

  it "displays authentication providers" do
    render

    expect(rendered).to have_selector(".authentication", count: 2)
  end
end

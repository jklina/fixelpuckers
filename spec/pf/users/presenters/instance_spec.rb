require 'users/presenters/instance'
require 'support/presenter_delegation_support'

describe Pf::Users::Presenters::Instance do
  it_behaves_like "an instance presenter"

  describe "#location" do
    context "when a location is present" do
      it "displays the location in the correct html" do
        user = double(location: "Philadelphia")
        presenter = described_class.for(user)
        formatted_location = "<span><i class=\"ss-icon\">location</i>Philadelphia</span>"
        expect(presenter.location).to eq(formatted_location)
      end
    end


    context "when a location isn't present" do
      it "returns nil" do
        user = double(location: nil)
        presenter = described_class.for(user)
        expect(presenter.location).to eq(nil)
      end
    end
  end

  describe "#email" do
    context "when a email is present" do
      it "displays the email in the correct html" do
        user = double(email: "bob@bob.com")
        presenter = described_class.for(user)
        formatted_email = "<span><i class=\"ss-icon\">send</i><a href=\"mailto:bob@bob.com\">bob@bob.com</a></span>"
        expect(presenter.email).to eq(formatted_email)
      end
    end


    context "when a email isn't present" do
      it "returns nil" do
        user = double(email: nil)
        presenter = described_class.for(user)
        expect(presenter.email).to eq(nil)
      end
    end
  end

  describe "#url" do
    context "when a url is present" do
      it "displays the url in the correct html" do
        user = double(domain: "test.com")
        presenter = described_class.for(user)
        formatted_url = "<span><i class=\"ss-icon\">world</i><a href=\"http://test.com\">test.com</a></span>"
        expect(presenter.url).to eq(formatted_url)
      end
    end


    context "when a url isn't present" do
      it "returns nil" do
        user = double(domain: nil)
        presenter = described_class.for(user)
        expect(presenter.url).to eq(nil)
      end
    end
  end
end

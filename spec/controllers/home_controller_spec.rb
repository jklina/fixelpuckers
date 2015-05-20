require 'spec_helper'

describe HomeController, type: :controller do
  describe "GET 'index'" do
    let(:submissions) { double }
    let(:feature) { double }

    before(:each) do
      allow(Submission).
        to receive_message_chain(:filtered_trash_for, :page, :per).
        and_return(submissions)
      allow(Feature).to receive(:first_or_initialize).and_return(feature)
      get :index
    end

    it "assigns non trashed submissions as @submissions" do
      expect(assigns(:submissions)).to eq(submissions)
    end

    it "assigns the latest featured to @featured" do
      expect(assigns(:feature)).to eq(feature)
    end
  end
end

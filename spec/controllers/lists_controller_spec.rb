require 'rails_helper'

describe ListsController do
  describe "Making JSON requests" do
    describe "A post request" do
      it "Should accept, and return JSON" do
        post "/lists", params: { title: "A thing"}
        expect(response).to be_successful

        puts response
      end
    end
  end
end

require 'rails_helper'
describe ListsController do
  describe "Making JSON requests" do
    describe "A post request" do
      it "Should accept, and return JSON" do
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        post :create, :title => "New List"
        expect(response).to be_successful
        actual_response = JSON.parse(response.body)
        expect(actual_response["status"]).to eq(201)
        expect(actual_response["list"]).to be_instance_of(Hash)
      end
    end
    describe "A put request" do
      it "Should accept, and return JSON" do
        list = List.create(title: "New List")
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        put :update, :id => list.id, :title => "Newer List"
        expect(response).to be_successful
        actual_response = JSON.parse(response.body)
        expect(actual_response["status"]).to eq(200)
        expect(actual_response["list"]).to be_instance_of(Hash)
        expect(actual_response["list"]["title"]).to eq("Newer List")
      end
    end
    describe "A delete request" do
      it "Should accept, and return JSON" do
        list = List.create(title: "New List")
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        delete :destroy, :id => list.id
        expect(response).to be_successful
        actual_response = JSON.parse(response.body)
        expect(actual_response["status"]).to eq(200)
        expect(actual_response["destroyed"]).to eq(true)
      end
    end
    describe "A index request" do
      it "Should accept, and return JSON" do
        List.create(title: "New List")
        List.create(title: "New List 2")
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        get :index
        expect(response).to be_successful
        actual_response = JSON.parse(response.body)
        expect(actual_response["status"]).to eq(200)
        expect(actual_response["lists"].count).to eq(2)
      end
    end
    describe "A show request" do
      it "Should accept, and return JSON" do
        list = List.create(title: "New List")
        @request.env["HTTP_ACCEPT"] = "application/json"
        @request.env["CONTENT_TYPE"] = "application/json"
        get :show, :id => list.id
        expect(response).to be_successful
        actual_response = JSON.parse(response.body)
        expect(actual_response["status"]).to eq(200)
        expect(actual_response["list"]).to be_instance_of(Hash)
      end
    end
  end
end

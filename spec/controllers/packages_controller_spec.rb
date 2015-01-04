require 'rails_helper'

RSpec.describe PackagesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      package = create(:package)
      get :show, id: package
      expect(response).to have_http_status(:success)
    end
  end

end

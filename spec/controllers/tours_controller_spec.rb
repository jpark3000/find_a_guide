require_relative '../spec_helper'
include OmniauthMacros

describe ToursController do

  let(:user) { FactoryGirl.create(:user) }

  # Route Testing
  describe "GET tours#index" do
    it "renders the :index template for the tour" do
      get :index, {user_id: user.id}
      expect(response).to render_template :index
    end
  end

  describe "GET tours#new" do
    it "renders the :new template for the tour" do
      get :new, {user_id: user.id}
      expect(response).to render_template :new
    end
  end

  describe "GET tours#show" do
    user = FactoryGirl.create(:user)
    user.tours.create(FactoryGirl.attributes_for(:tour))
    it "renders the :show template for the tour" do
      get :show, user_id: user.id, id: user.tours.last.id
      expect(response).to render_template :show
    end
  end

  #Object Creation Testing

  describe "POST  tours#create_______" do
    it "_______________" do
      pending
    end
  end

  describe "PATCH tours#update _______" do
    it "_______________" do
      pending
    end
  end

  describe "DELETE tours#destroy _______" do
    it "_______________" do
      pending
    end
  end

  describe "PUT tours#update _______" do
    it "_______________" do
      pending
    end
  end

end #End ReviewsController controller


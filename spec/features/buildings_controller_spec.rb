require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
  render_views
  describe "GET#index buildings without params" do
    before do
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "get JSON body response" do
      json_parse = JSON.parse(response.body)
      json_parse.count.should be > 0
    end
  end

  describe "GET#index buildings with params" do
    before do
      get :index, params: {distance: Building::INFO[:distance], coordinates: Building::INFO[:center_coordinates]},format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "get JSON body response" do
      json_parse = JSON.parse(response.body)
      json_parse.count.should be > 0
    end
  end

  describe "POST#create create building" do
    before do
      post :create, params: {building: {street: 'Октябрьский проспект', house: '17' }}, format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "get JSON body response" do
      json_parse = JSON.parse(response.body)
      expect(json_parse['message']).to eq('Здание успешно добавлено')
    end
  end

  describe "POST#create check validate" do
    before do
      post :create, params: {building: {street: '', house: '' }}, format: :json
    end

    it "returns http unprocessable_entity" do
      post :create, params: {building: {street: '', house: '' }}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "get JSON body response" do
      json_parse = JSON.parse(response.body)
      expect(json_parse['message']).to eq('Ошибка')
    end
  end

  describe "DELETE#destroy building" do
    before do
      delete :destroy, params: {id: Building.first.id}, format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "get JSON body response" do
      json_parse = JSON.parse(response.body)
      expect(json_parse['message']).to eq('Здание успешно удалено')
    end
  end

end
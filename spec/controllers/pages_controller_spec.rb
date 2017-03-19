require 'rails_helper'

describe PagesController do
  before(:each) do
    @page = create(:page)
  end

  describe 'GET index' do
    it 'loads all pages into @pages' do
      get :index

      expect(response.status).to eq(200)
      expect(assigns(:pages)).to match_array(@page)
    end
  end

  describe 'GET show' do
    it 'should show a page' do
      get :show, params: { id: @page }

      expect(response.status).to eq(200)
    end
  end
end

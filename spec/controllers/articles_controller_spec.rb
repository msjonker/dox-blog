require 'rails_helper'

describe ArticlesController do
  describe 'GET index' do
    let!(:articles) { create_list :article, 2 }
    let!(:featured_articles) { create_list :article, 2, :featured }

    before :each do
      get :index
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'loads articles into @articles except the featured article' do
      expect(assigns(:articles)).to match_array(articles + featured_articles - [assigns(:featured_article)])
    end

    it 'loads a featured_article into @featured_article' do
      expect(assigns(:featured_article)).to be_present
    end
  end

  describe 'GET show' do
    let!(:article) { create :article}

    it 'should show a page' do
      get :show, params: { id: article }

      expect(response.status).to eq(200)
    end
  end

  describe 'GET search' do
    let!(:matching_article) { create :article, title: 'Testing 123', body: 'This is a test.'}
    let!(:nonmatching_article) { create :article, title: 'Nonmatch', body: 'Does not match.'}

    before :each do
      get :search, query: 'testing'
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'loads matching articles into @articles' do
      expect(assigns(:articles)).to match_array([matching_article])
    end
  end
end

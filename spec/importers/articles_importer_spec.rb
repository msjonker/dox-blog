require 'rails_helper'

RSpec.describe ArticlesImporter do
  describe '.import' do

    let(:path) { File.join(Rails.root, 'db', 'data', 'articles.csv') }

    before :each do
      subject.class.import(path)
    end

    it 'imports all articles' do
      expect(Article.count).to eq 500
    end

  end
end
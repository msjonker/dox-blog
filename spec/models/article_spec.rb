require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.import' do

    let(:file) { File.new File.join(Rails.root, 'db', 'data', 'articles.csv') }

    before :each do
      subject.class.import(file)
    end

    it 'imports all articles' do
      expect(Article.count).to eq 500
    end

  end
end
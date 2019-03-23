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

  describe '.containing_text' do

    subject { Article.containing_text(query) }
    let(:matching_text) { 'This is a test.' }
    let(:nonmatching_text) { 'blank' }

    shared_examples 'search examples' do
      context 'does not contain the text' do
        let(:query) { 'miss' }

        it { is_expected.to be_empty }
      end

      context 'does contain the full text' do
        let(:query) { matching_text }

        it { is_expected.to contain_exactly(article) }
      end

      context 'contains the text in a different order' do
        let(:query) { matching_text.split(' ').reverse.join(' ') }

        it { is_expected.to contain_exactly(article) }
      end
    end

    context 'query text' do
      context 'in title' do
        let!(:article) { create :article, title: matching_text, body: nonmatching_text }

        it_behaves_like 'search examples'
      end

      context 'in body' do
        let!(:article) { create :article, title: nonmatching_text, body: matching_text }

        it_behaves_like 'search examples'
      end
    end
  end
end
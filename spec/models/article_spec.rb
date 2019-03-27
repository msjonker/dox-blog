require 'rails_helper'

RSpec.describe Article, type: :model do

  describe '.containing_query' do
    subject { Article.containing_query([:title, :body], query) }
    let(:matching_text) { 'This is a test.' }
    let(:nonmatching_text) { 'blank' }

    shared_examples 'search examples' do
      context 'does not contain the text' do
        let(:query) { 'miss' }

        it { is_expected.to be_empty }
      end

      context 'does contain a token from the text' do
        let(:query) { 'test' }

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

  describe '.search' do
    subject { Article.search(Article.all, [:title, :body], query) }
    let(:query) { 'test'}

    context 'frequency sorting' do
      let!(:article1) { create :article, title: "This contains #{query}", body: 'miss' }
      let!(:article2) { create :article, title: "This contains #{query} and #{query}", body: 'miss' }

      it 'sorts multiple word matches above a single match' do
        is_expected.to eq [article2, article1]
      end
    end

    context 'field length sorting' do
      let!(:article1) { create :article, title: 'miss', body: "This body contains the #{query}." }
      let!(:article2) { create :article, title: query, body: 'miss' }

      it 'sorts title matches higher than body matches' do
        is_expected.to eq [article2, article1]
      end
    end
  end
end
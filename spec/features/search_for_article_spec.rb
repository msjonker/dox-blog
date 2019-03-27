require 'rails_helper'

describe 'User searches for articles', :type => :feature, js: true do
  let!(:article) { create :article, :airplane_hero_image_name, title: 'testing', body: 'Body' }

  scenario 'articles match' do
    perform_search('testing')
    expect(page).to have_css('div.article strong')
    expect(page).to have_no_text('No articles found')
  end

  scenario 'articles do not match' do
    perform_search('miss')
    expect(page).to have_text('No articles found')
  end

  private

  def perform_search(query)
    visit '/'
    fill_in '[query]', with: query
    click_button 'search'
    expect(page).to have_text("Search results for \"#{query}\"")
  end
end

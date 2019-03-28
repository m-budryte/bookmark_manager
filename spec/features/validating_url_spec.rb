feature 'the app checks if the URL submitted by user is valid' do
  scenario 'raises an error if the URL is not valid' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit '/bookmarks/new'
    fill_in :url, with: 'twitter'
    fill_in :title, with: 'Twitter'
    click_button 'Submit'
    expect(page).to have_content('Invalid url!')
  end
end

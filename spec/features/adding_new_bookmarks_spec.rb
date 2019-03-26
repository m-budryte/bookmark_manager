feature 'Adding bookmarks' do
  scenario 'the bookmark can be added to the manager' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit '/bookmarks/new'

    fill_in :url, with: 'http://twitter.com'
    click_button 'Submit'

		expect(page).to have_content 'http://twitter.com'
  end
end

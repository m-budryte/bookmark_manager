feature 'Adding bookmarks' do
  scenario 'the bookmark can be added to the manager' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit '/bookmarks/new'

    fill_in :url, with: 'http://twitter.com'
    fill_in :title, with: 'Twitter'
    click_button 'Submit'
		expect(page).to have_link('Twitter', href: 'http://twitter.com')
  end
end

feature 'Viewing bookmarks' do
  scenario 'the bookmarks are displayed on the page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.add(url: 'http://makersacademy.com')
    Bookmark.add(url: 'http://google.com')
    Bookmark.add(url: 'http://destroyallsoftware.com')

    visit '/bookmarks'
		expect(page).to have_content "http://makersacademy.com"
		expect(page).to have_content "http://google.com"
    expect(page).to have_content "http://destroyallsoftware.com"
  end
end

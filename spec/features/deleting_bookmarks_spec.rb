feature 'Deleting bookmarks' do
  scenario 'the user delets a bookmark' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.add(url: "http://www.makersacademy.com", title: "Makers Academy")
    visit '/bookmarks'
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'

    expect(page).not_to have_link('Makers Academy', href:"http://www.makersacademy.com")
  end
end

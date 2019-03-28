# frozen_string_literal: true

feature 'Updating bookmarks' do
  scenario 'the user delets a bookmark' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    bookmark = Bookmark.add(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/bookmarks'
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Edit'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.sneakersacademy.com')
    fill_in('title', with: 'Sneakers Academy')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Sneakers Academy', href: 'http://www.sneakersacademy.com')
  end
end

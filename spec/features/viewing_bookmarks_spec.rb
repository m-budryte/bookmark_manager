feature 'Viewing bookmarks' do
  scenario 'the bookmarks are displayed on the page' do
    visit '/bookmarks'
    expect(page).to have_content("google")
  end
end

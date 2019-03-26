feature 'Viewing bookmarks' do
  scenario 'the bookmarks are displayed on the page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

		# Add the test data
		connection.exec("INSERT INTO bookmarks VALUES(1, 'http://makersacademy.com');")
		connection.exec("INSERT INTO bookmarks VALUES(2, 'http://google.com');")
		connection.exec("INSERT INTO bookmarks VALUES(3, 'http://destroyallsoftware.com');")

    visit '/bookmarks'
		expect(page).to have_content "http://makersacademy.com"
		expect(page).to have_content "http://google.com"
  end
end

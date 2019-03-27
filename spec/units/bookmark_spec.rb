require 'bookmark'
describe Bookmark do
  subject(:bookmarks) { described_class }
  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    bookmark = Bookmark.add(url: "http://www.makersacademy.com", title: "Makers Academy")
    Bookmark.add(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
    Bookmark.add(url: "http://www.google.com", title: "Google")

    bookmarks = Bookmark.all

    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
  end

  describe '#add' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.add(url: 'http://twitter.com', title: 'Twitter')

      expect(bookmark.url).to eq 'http://twitter.com'
      expect(bookmark.title).to eq 'Twitter'
    end
  end

  describe '#delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add(url: 'http://twitter.com', title: 'Twitter')
      bookmark = Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end
end

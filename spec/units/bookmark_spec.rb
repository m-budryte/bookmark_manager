# frozen_string_literal: true
require 'database_helpers'
require 'bookmark'
describe Bookmark do
  connection = PG.connect(dbname: 'bookmark_manager_test')
  subject(:bookmarks) { described_class }
  it 'returns a list of bookmarks' do
    bookmark = Bookmark.add(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    persisted_data = persisted_data(id: bookmark.id, table: 'bookmarks')
    Bookmark.add(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmark.add(url: 'http://www.google.com', title: 'Google')

    bookmarks = Bookmark.all

    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    expect(bookmark.id).to eq persisted_data.first['id']
  end

  describe '#add' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    it 'creates a new bookmark' do
      bookmark = Bookmark.add(url:'http://twitter.com', title: 'Twitter')

      expect(bookmark.url).to eq 'http://twitter.com'
      expect(bookmark.title).to eq 'Twitter'
    end

    it 'doesnot create a new bookmark if the url is not valid' do
      bookmark = Bookmark.add(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).not_to include bookmark
    end
  end

  describe '#delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add(url: 'http://twitter.com', title: 'Twitter')
      bookmark = Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.add(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.sneakersacademy.com', title: 'Sneakers Academy')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Sneakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.sneakersacademy.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.add(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end

let(:comment_class) { double(:comment_class) }

describe '#comments' do
  it 'calls .where on the Comment class' do
    bookmark = Bookmark.add(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

    bookmark.comments(comment_class)
  end
end
end

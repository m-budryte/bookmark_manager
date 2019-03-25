require 'bookmark'
describe Bookmark do
  subject(:bookmarks) { described_class }
  it 'accepts the method #all' do
    expect(bookmarks).to respond_to(:all)
  end

  it 'returns an array' do
    expect(bookmarks.all).to include("http://www.google.com")
  end

  it 'returns extra links e.g. twitter' do
    expect(bookmarks.all).to include("http://www.twitter.com")
  end
end

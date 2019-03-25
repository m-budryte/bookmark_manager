require 'sinatra/base'
require './lib/bookmark.rb'
class BookmarkManager < Sinatra::Base
  # enable :sessions
  # configure(:development) { set :session_secret, "something" }
  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  run! if app_file == $PROGRAM_NAME
end

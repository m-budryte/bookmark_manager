require 'sinatra/base'
require './lib/bookmark.rb'
require 'pg'

class BookmarkManager < Sinatra::Base
  # enable :sessions
  # configure(:development) { set :session_secret, "something" }
  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb(:"bookmarks/new")
  end

  post '/bookmarks' do
    Bookmark.add(url: params['url'])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end

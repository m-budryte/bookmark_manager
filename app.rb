# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'pg'
require './lib/bookmark.rb'
require './lib/database_connection_setup.rb'
require 'uri'


class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash
  configure(:development) { set :session_secret, 'something' }

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb(:"bookmarks/new")
  end

  post '/bookmarks' do
    flash[:notice] = 'Invalid url!' unless Bookmark.add(url: params['url'], title: params['title'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect('/bookmarks')
  end

  run! if app_file == $PROGRAM_NAME
end

class ListsController < ApplicationController

  get '/lists/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'lists/new'
    end
  end

  post '/lists' do
    if params[:title].empty?
      redirect '/lists/new'
    else
      current_user.lists.create(:title => params[:title])
      redirect '/'
    end
  end
end

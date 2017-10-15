class ListItemsController < ApplicationController

  get '/items/new/:id' do
    if !logged_in?
      redirect '/login'
    else
      @list = List.find_by_id(params[:id])
      erb :'items/new'
    end
  end

  post '/items/new/:id' do
    if params[:word_number].empty? || params[:description].empty?
      redirect '/items/new'
    else
      ListItem.create(:description => params[:description], :word_number => params[:word_number], :list_id => params[:id])
      redirect '/'
    end
  end

  get '/items/:id/edit' do
  end

  patch '/items/:id/edit' do
  end

  delete '/items/:id/delete' do
  end

end

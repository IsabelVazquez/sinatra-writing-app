class ListItemsController < ApplicationController

  get '/items/new/:id' do
    @list = List.find_by_id(params[:id])
    if logged_in? && @list.writer_id == current_user.id
      erb :'items/new'
    else
      redirect '/login'
    end
  end

  post '/items/new/:id' do
    @list = List.find_by_id(params[:id])
    ListItem.create(:description => params[:description], :word_number => params[:word_number], :list_id => params[:id])
    redirect '/'
  end

  get '/items/:id/edit' do
    @list = List.find_by_id(params[:id])
    if logged_in? && @list.writer_id == current_user.id
      erb :'items/edit'
    else
      redirect '/login'
    end
  end

  patch '/items/:id/edit' do
    @item = ListItem.find_by_id(params[:id])
    @item.description = params[:description]
    @item.word_number = params[:word_number]
    @item.save
    redirect '/'
  end

  delete '/items/:id/delete/' do
    @item = ListItem.find_by_id(params[:id])
    if logged_in? && (current_user.id == @item.list_id.writer_id)
      @item.delete
      redirect '/'
    else
      redirect "/login"
    end
  end

end

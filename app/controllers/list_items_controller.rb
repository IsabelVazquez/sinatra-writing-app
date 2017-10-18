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
    @list = List.find_by_id(params[:id]) # find_by instead of find
    list_item = ListItem.new(:description => params[:description], :word_number => params[:word_number], :list_id => params[:id])
    if list_item.save
      redirect '/'
    else
      erb :'items/new', locals: {
        message: list_item.errors.full_messages.join(', ')
      }
    end
  end

  get '/items/:item_id/edit/:id' do
    @list = List.find_by_id(params[:id])
    @item = ListItem.find_by_id(params[:item_id])
    if logged_in? && @list.writer_id == current_user.id
      erb :'items/edit'
    else
      redirect '/login'
    end
  end

  patch '/items/:item_id/edit/:id' do
    # update
    @item = ListItem.find_by_id(params[:item_id])
    @item.description = params[:description]
    @item.word_number = params[:word_number]
    @item.save
    redirect '/'
  end

  delete '/items/:id/delete' do
    @item = ListItem.find_by_id(params[:id])
    if logged_in? && (current_user.id == List.find_by_id(@item.list_id).writer_id)
      @item.delete
      redirect '/'
    else
      redirect "/"
    end
  end
end

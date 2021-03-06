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
    list_item = ListItem.new(:description => params[:description],
      :word_number => params[:word_number],
      :list_id => params[:id])
    if list_item.save
      redirect '/'
    else
      erb :'items/new', locals: {
        message: list_item.errors.full_messages.join(', ')
      }
    end
  end

  get '/items/:item_id/edit/:id' do
    @list = List.find_by(:id => params[:id])
    @item = ListItem.find_by(:id => params[:item_id])
    if logged_in? && @list.writer_id == current_user.id
      erb :'items/edit'
    else
      redirect '/login'
    end
  end

  post '/items/:item_id/edit/:id' do
    @list = List.find_by(:id => params[:id])
    @item = ListItem.find_by(:id => params[:item_id])
    @item.update(:description => params[:description],
      :word_number => params[:word_number])
    if @item.save
      redirect '/'
    else
      erb :'items/edit', locals: {
        message: @item.errors.full_messages.join(', ')
      }
    end
  end

  delete '/items/:id' do
    @item = ListItem.find_by_id(params[:id])
    if logged_in? && (current_user.id == List.find_by_id(@item.list_id).writer_id)
      @item.delete
      redirect '/'
    else
      redirect '/'
    end
  end
end

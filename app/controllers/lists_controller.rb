class ListsController < ApplicationController

  get '/lists/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'lists/new'
    end
  end

  post '/lists/new' do
    list = current_user.lists.new(:title => params[:title]) # build == new
    if list.save
      list_item = ListItem.new(:description => params[:list_items][:description], :word_number => params[:list_items][:word_number])
      if list_item.save
        list.list_items << list_item
        redirect '/'
      else
        erb :'lists/new', locals: {
          message: list_item.errors.full_messages.join(', ')
        }
      end
    else
      erb :'lists/new', locals: {
        message: list.errors.full_messages.join(', ')
      }
    end
  end

  get '/lists/:id/edit' do
    @list = List.find_by_id(params[:id])
    if logged_in?
      if @list.writer_id == current_user.id
        erb :'lists/edit'
      else
        redirect '/'
      end
    else
      redirect '/login'
    end
  end

  patch '/lists/:id/edit' do
    @list = List.find_by_id(params[:id])
    if @list.writer_id = session[:writer_id]
      @list.title = params[:title]
      @list.save
      redirect '/'
    else
      redirect '/'
    end
  end

  delete '/lists/:id/delete' do
    @list = List.find_by_id(params[:id])
    if logged_in? && (current_user.id == @list.writer_id)
      @list.delete
      redirect '/'
    else
      redirect "/login"
    end
  end
end

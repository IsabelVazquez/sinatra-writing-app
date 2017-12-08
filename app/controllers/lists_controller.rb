class ListsController < ApplicationController

  get '/lists/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'lists/new'
    end
  end

  post '/lists' do
    # collection.build instantiates objects but not save them
    list = current_user.lists.build(:title => params[:title]) # build == new
    if !params[:list_items][:word_number].empty? || !params[:list_items][:description].empty?
      list_item = list.list_items.build(
        :description => params[:list_items][:description],
        :word_number => params[:list_items][:word_number])
      if list_item.save
        redirect '/'
      else
        erb :'lists/new', locals: {
          message: list_item.errors.full_messages.join(', ')
        }
      end
    else
      if list.save
        redirect '/'
      else
        erb :'lists/new', locals: {
          message: list.errors.full_messages.join(', ')
        }
      end
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

  put '/lists/:id' do
    @list = List.find_by_id(params[:id])
    if @list.writer_id = session[:writer_id]
      @list.update(:title => params[:title])
      if @list.save
        redirect '/'
      else
        erb :'lists/edit', locals: {
          message: @list.errors.full_messages.join(', ')
        }
      end
    else
      redirect '/'
    end
  end

  delete '/lists/:id' do
    @list = List.find_by_id(params[:id])
    if logged_in? && (current_user.id == @list.writer.id)
      @list.destroy
      redirect '/'
    else
      redirect "/login"
    end
  end
end

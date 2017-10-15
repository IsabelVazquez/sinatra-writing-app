class ListsController < ApplicationController

  get '/lists/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'lists/new'
    end
  end

  post '/lists/new' do
    if params[:title].empty?
      erb :'lists/new', locals: {message: "Please fill out a title."}
    else
      list = current_user.lists.create(:title => params[:title])
      list_item = ListItem.create(:description => params[:list_items][:description], :word_number => params[:list_items][:word_number])
      list.list_items << list_item
      redirect '/'
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

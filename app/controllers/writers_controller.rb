class WritersController < ApplicationController
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= Writer.find_by_id(session[:writer_id]) if session[:writer_id]
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'writers/signup'
    else
      redirect '/'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      writer = Writer.new(:username => params[:username], :email => params[:email], :password => params[:password])
      writer.save
      session[:writer_id] = writer.id
      redirect '/'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'writers/login'
    else
      redirect '/'
    end
  end

  post '/login' do
    writer = Writer.find_by(:username => params[:username])
    # works but stores password in plain text 
    if writer && (writer.password == params[:password])
      session[:writer_id] = writer.id
      redirect '/'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end

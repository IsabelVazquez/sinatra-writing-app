class WritersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'writers/signup'
    else
      redirect '/'
    end
  end

  post '/signup' do
    writer = Writer.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if writer.save
      session[:writer_id] = writer.id
      redirect '/'
    else
      erb :'writers/signup', locals: {
        message: writer.errors.full_messages.join(', ')
      }
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
    if writer && writer.authenticate(params[:password])
      session[:writer_id] = writer.id
      redirect '/'
    else
      erb :'writers/login', locals: {message: "Please enter the correct username and corresponding password."}
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

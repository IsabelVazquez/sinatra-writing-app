require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "writer_secret"
  end

  get '/' do
    @lists = List.all
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= Writer.find_by_id(session[:writer_id]) if session[:writer_id]
    end
  end

end

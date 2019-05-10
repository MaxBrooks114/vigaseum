require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
    enable :sessions
    set :session_secret, "vigaseum"
    use Rack::Flash
  end

  get "/" do
    erb :welcome
  end



  helpers do
   def redirect_if_not_logged_in
     if !logged_in?
       redirect "/login?error=You have to be logged in to do that"
     end
   end

   def logged_in?
     !!session[:user_id]
   end

   def current_user
     User.find(session[:user_id])
   end

  end

end

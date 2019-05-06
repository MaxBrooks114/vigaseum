class UserController < ApplicationController

  get '/users/:id' do
     if !logged_in?
       redirect '/games'
     end

     @user = User.find(params[:id])
     if !@user.nil? && @user == current_user
       erb :'users/show'
     else
       redirect '/games'
     end
   end

   get '/signup' do
     if !session[:user_id]
       erb :'users/signup'
     else
       redirect to '/games'
     end
   end

   post '/signup' do
     if params[:username].empty?|| params[:password].empty?
       redirect to '/signup'
     else
       @user = User.create(:username => params[:username], :password => params[:password])
       session[:user_id] = @user.id
       redirect '/games'
     end
   end

   get '/login' do
     @error_message = params[:error]
     if !session[:user_id]
       erb :'users/login'
     else
       redirect '/bags'
     end
   end

   post '/login' do
     user = User.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect "/games"
     else
       redirect to '/signup'
     end
   end

   get '/logout' do
     if session[:user_id] != nil
       session.destroy
       redirect to '/login'
     else
       redirect to '/'
     end
   end

 end

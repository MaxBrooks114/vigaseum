
class UsersController < ApplicationController


   get '/signup' do
     if !session[:user_id]
       erb :'users/signup'
     else
       redirect to "/collection"
     end
   end

   post '/signup' do
     if params[:username].empty?|| params[:password].empty? || params[:email].empty?
       redirect to '/signup'
     elsif !User.new(params[:user]).valid?
       redirect to '/login'
     else
       @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
       session[:user_id] = user.id
       redirect "/collection"
     end
   end

   get '/login' do
     if !logged_in?
       erb :'users/login'
     else
       redirect  "/collection"
     end
   end

   post '/login' do
     user = User.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect "/collection"
     else
       redirect to '/login'
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

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

 end

class UsersController < ApplicationController


   get '/signup' do
     if !logged_in?
       erb :'users/signup'
     else
       @user = current_user #set
       session[:user_id] = @user.id
       redirect "/users/#{@user.slug}"
     end
   end

   post '/signup' do
     if !User.new(params).valid?
        redirect '/signup?error=invalid User'
     else
       @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
       session[:user_id] = @user.id
       redirect "/users/#{@user.slug}"
     end
   end

   get '/login' do
     if !logged_in?
       erb :'users/login'
     else
       @user = current_user
       session[:user_id] = @user.id
       redirect "/users/#{@user.slug}"
     end
   end

   post '/login' do
     @user = User.find_by(:username => params[:username])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect "/users/#{@user.slug}"
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
   redirect_if_not_logged_in
   @user = User.find_by_slug(params[:slug])
   @user = current_user
   if current_user
      erb :'/users/show'
    else
      redirect '/login'
    end
 end


end

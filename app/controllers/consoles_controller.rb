require 'pry'
class ConsolesController < ApplicationController

   get '/consoles' do
    redirect_if_not_logged_in
    @user = current_user
    @consoles = @user.consoles
    erb :'consoles/index'
  end

  get '/consoles/new' do
    redirect_if_not_logged_in
    erb :'consoles/new'
  end

  get "/consoles/:slug/edit" do
    redirect_if_not_logged_in
    @user = current_user
    @console = @user.consoles.find_by_slug(params[:slug])
    if current_user.id == @console.user_id
      erb :'consoles/edit'
    end
  end

  get '/consoles/:slug' do
    redirect_if_not_logged_in
    @user = current_user
    @console = @user.consoles.find_by_slug(params[:slug])
    if current_user
      erb :'consoles/show'
    else
      redirect '/login'
    end
  end

  post "/consoles" do
    redirect_if_not_logged_in
    @user= current_user
    unless Console.new(params).valid?
      redirect "/consoles/new?error=invalid Console"
    end
    @console = Console.new(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
    @console.user = current_user
    @console.save
    redirect "/consoles"
  end


  patch '/consoles/:slug' do
  redirect_if_not_logged_in
  @user = current_user
  console = @user.consoles.find_by_slug(params[:slug])
  if params[:name].empty?
    redirect "/consoles/#{params[:slug]}/edit?error=please enter valid information"
  end
     console = @user.consoles.find_by_slug(params[:slug])
     console.update(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
     console.save
     redirect "/consoles/#{console.slug}"
 end

 post '/consoles/:slug/delete' do
   redirect_if_not_logged_in
   @user = current_user
   @console = Console.where(:user_id == @user.id).find_by_slug(params[:slug])
   if logged_in? && current_user.id == @console.user_id
     @console.destroy
     redirect '/consoles'
   else
     redirect "/consoles/#{@console.slug}"
   end
 end

 get '/consoles/games/:slug' do
    redirect_if_not_logged_in
    @user = current_user
    @game = @user.games.find_by_slug(params[:slug])
    redirect "games/#{@game.slug}"
 end

end

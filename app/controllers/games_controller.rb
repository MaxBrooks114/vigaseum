class GamesController < ApplicationController

   get '/games' do
    redirect_if_not_logged_in
    @games = Game.all
    @user = current_user
    erb :'games/index'
  end

  get "/games/new" do
    redirect_if_not_logged_in
    @consoles = Console.all
    erb :'games/new'
  end

  get "/games/:slug/edit" do
    redirect_if_not_logged_in
    @game = Game.find_by_slug(params[:slug])
    erb :'games/edit'
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])
    if current_user
      erb :'games/show'
    else
      redirect '/login'
    end
  end

  post "/games" do
    redirect_if_not_logged_in
    @user= current_user
    unless Game.new(:name => params[:name]).valid?
      redirect "/games/new?error=invalid Game"
    end
    @game = Game.new(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
    @game.user = current_user
    @game.save
    redirect "/games"
  end


  patch '/games/:slug' do
#    if logged_in?
     game = Game.find_by_slug(params[:slug])
     game.update(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
     game.save
      redirect "/games/#{game.slug}"
#    else
#      redirect "/games/#{params[:slug]}/edit"
#    end
 end

 post '/games/:slug/delete' do
   @game = Game.find_by_slug(params[:slug])
   @user = current_user
   if logged_in?
     @game.delete
     redirect '/games'
   else
     redirect "/games/#{@game.slug}"
   end
 end



end

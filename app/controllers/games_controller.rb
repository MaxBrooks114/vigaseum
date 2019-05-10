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
    if @consoles== []
      redirect 'consoles/new?error=please add a console before you add any games for that console'
    else
      erb :'games/new'
    end
  end

  get "/games/:slug/edit" do
    redirect_if_not_logged_in
    @consoles = Console.all
    @game = Game.find_by_slug(params[:slug])
    erb :'games/edit'
  end

  get '/games/:slug' do
    redirect_if_not_logged_in
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
    unless Game.new(params).valid?
      redirect "/games/new?error=invalid Game"
    end
    @game = Game.new(:name => params[:name], :developer=> params[:developer], :date_added => params[:date_added], :genre => params[:genre], :review => params[:review], :console_id => params[:console_id])
    @game.user = current_user
    @game.save
    redirect "/games"
  end


  patch '/games/:slug' do
   redirect_if_not_logged_in
   game = Game.find_by_slug(params[:slug])
   if game(params).valid?
     game.update(:name => params[:name], :developer=> params[:developer], :date_added => params[:date_added], :genre => params[:genre], :review => params[:review], :console_id => params[:console_id])
     game.save
    redirect "/games/#{game.slug}"
   else
     redirect "/games/#{params[:slug]}/edit"
   end
 end

 post '/games/:slug/delete' do
   redirect_if_not_logged_in
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

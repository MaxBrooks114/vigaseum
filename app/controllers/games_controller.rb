class GamesController < ApplicationController

  get '/games' do
    redirect_if_not_logged_in
    @user = current_user
    @games = @user.games
    erb :'games/index'
  end

  get "/games/new" do
    redirect_if_not_logged_in
    @user = current_user
    @consoles = @user.consoles
    if @consoles == []
      redirect 'consoles/new?error=please add a console before you add any games for that console'
    else
      erb :'games/new'
    end
  end

  get "/games/:slug/edit" do
    redirect_if_not_logged_in
    @user = current_user
    @consoles = @user.consoles
    @game = @user.games.find_by_slug(params[:slug])
    if current_user.id == @game.user_id
      erb :'games/edit'
    end
  end

  get '/games/:slug' do
    redirect_if_not_logged_in
    @user = current_user
    @game = @user.games.find_by_slug(params[:slug])
    if current_user
      erb :'games/show'
    else
      redirect '/login'
    end
  end

  post "/games" do
    redirect_if_not_logged_in
    @user= current_user
    if !Game.new(params).valid?
      redirect "/games/new?error=invalid Game"
    else
      @game = Game.new(:name => params[:name], :developer=> params[:developer], :date_added => params[:date_added], :genre => params[:genre], :review => params[:review], :console_id => params[:console_id])
      @game.user = current_user
      @game.save
      redirect "/games"
    end
  end


  patch '/games/:slug' do
   redirect_if_not_logged_in
   @user = current_user
   game = @user.games.find_by_slug(params[:slug])
   if !params[:name].empty?
      game.update(:name => params[:name], :developer=> params[:developer], :date_added => params[:date_added], :genre => params[:genre], :review => params[:review], :console_id => params[:console_id])
      game.save
      redirect "/games/#{game.slug}"
   else
     redirect "/games/#{params[:slug]}/edit?error=please enter valid information"
   end
 end

 post '/games/:slug/delete' do
   redirect_if_not_logged_in
   @user = current_user
   @game = Game.where(:user_id == @user.id).find_by_slug(params[:slug])
   if logged_in? && current_user.id == @game.user_id
     @game.delete
     redirect '/games'
   else
     redirect "/games/#{@game.slug}"
   end
 end



end

class ConsolesController < ApplicationController

   get '/consoles' do
    redirect_if_not_logged_in
    @consoles = Console.all
    @user = current_user
    erb :'consoles/index'
  end

  get "/consoles/new" do
    redirect_if_not_logged_in

    erb :'consoles/new'
  end

  get "/consoles/:slug/edit" do
    redirect_if_not_logged_in
    @console = Console.find_by_slug(params[:slug])
    erb :'consoles/edit'
  end

  get '/consoles/:slug' do
    @console = Console.find_by_slug(params[:slug])
    if current_user
      erb :'consoles/show'
    else
      redirect '/login'
    end
  end

  post "/consoles" do
    redirect_if_not_logged_in
    @user= current_user
    unless Console.new(:name => params[:name]).valid?
      redirect "/consoles/new?error=invalid Console"
    end
    @console = Console.new(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
    @console.user = current_user
    @console.save
    redirect "/consoles"
  end


  patch '/consoles/:slug' do
   if logged_in?
     @console = Console.find_by_slug(params[:slug])
     @Console.update(:name => params[:name], :company => params[:company], :date_added => params[:date_added], :generation => params[:generation])
     @console.save
     erb :'consoles/show'
   else
     redirect "/consoles/#{params[:slug]}/edit"
   end
 end

 post '/consoles/:slug/delete' do
   @console = Console.find_by_slug(params[:slug])
   @user = current_user
   if logged_in?
     @console.delete
     redirect '/consoles'
   else
     redirect "/consoles/#{@console.slug}"
   end
 end



end

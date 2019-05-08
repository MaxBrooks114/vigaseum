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
    erb :'console/edit'
  end

  post "/consoles/:slug" do
    redirect_if_not_logged_in
    @console = Console.find_by_slug(params[:slug])
    unless Console.new(:name => params[:name]).valid?
      redirect "/consoles/#{@console.slug}/edit?error=invalid console"
    end
    @Console.update(params("console"))
    redirect "/consoles/#{@console.slug}"
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



end

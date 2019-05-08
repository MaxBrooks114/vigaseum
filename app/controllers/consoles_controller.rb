class ConsolesController < ApplicationController

   get '/consoles' do
    redirect_if_not_logged_in
    consoles = Console.all
    @user = current_user
    erb :'consoles/index'
  end

  get "/consoles/new" do
    redirect_if_not_logged_in

    erb :'consoles/new'
  end

  get "/consoles/:slug/edit" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    erb :'console/edit'
  end

  post "/consoles/:slug" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    unless Console.valid_params?(params)
      redirect "/console/#{@console.slug}/edit?error=invalid console"
    end
    @Console.update(params("console"))
    redirect "/consoles/#{@console.slug}"
  end

  get "/consoles/:slug" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    erb :'consoles/show'
  end

  post "/consoles" do
    redirect_if_not_logged_in
    @user= current_user
    unless Console.new(params).valid?
      redirect "/consoles/new?error=invalid Console"
    end
    @console = Console.create(params)
    @user.consoles << @console
    redirect "/consoles"
  end



end

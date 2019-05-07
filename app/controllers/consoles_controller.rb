class ConsolesController < ApplicationController

   get "/consoles" do
    redirect_if_not_logged_in
    consoles = Console.all
    @user = current_user
    erb :'consoles/index'
  end

  get "/consoles/new" do
    redirect_if_not_logged_in

    erb :'consoles/new'
  end

  get "/consoles/:id/edit" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    erb :'console/edit'
  end

  post "/consoles/:id" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    unless Console.valid_params?(params)
      redirect "/console/#{@console.id}/edit?error=invalid console"
    end
    @Console.update(params("console"))
    redirect "/consoles/#{@console.id}"
  end

  get "/consoles/:id" do
    redirect_if_not_logged_in
    @console = Console.find(params[:id])
    erb :'consoles/show'
  end

  post "/consoles" do
    redirect_if_not_logged_in

    unless Console.valid_params?(params)
      redirect "/consoles/new?error=invalid Console"
    end
    Console.create(params)
    redirect "/consoles"
  end



end
class UsersController < ApplicationController

  get '/users/#{user.slug}' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    !logged_in? ? (erb :"/users/create_user") : (redirect to "/tweets")
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/signup"
    else
      @user = User.new(username: params[:username], password: params[:password], email: params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    logged_in? ? (erb :"/users/login") : (redirect to "/tweets")
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      seesion[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end
end

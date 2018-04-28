class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    logged_in? ? (erb :"/tweets/create_tweet") : (redirect to "/login")
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect to "/tweets/#{@tweet.id}" if @tweet.save
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        erb :"/tweets/edit_tweet"
      else
        redirect to "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] = ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        @tweet.delete
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end
end

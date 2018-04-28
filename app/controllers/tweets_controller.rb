class TweetsController < ApplicationController

  get '/tweets' do
    logged_in? ? (@tweets = Tweet.all erb :"/tweets/tweets") : (redirect "/login")
  end

  get '/tweets/new' do
    logged_in? ? (erb :"/tweets/create_tweet") : (redirect "/login")
  end

  post '/tweets' do
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end

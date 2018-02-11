class HomeController < ApplicationController
  before_action :authorized?, only: [:show] # Redirects user to the index page
  before_action :unauthorized?, only: [:index] # Redirects user to the show page
  
  def index
    @url = Instagram.authorize_url(:redirect_uri => REDIRECT_URI)
    
    # Caches the access token from the authorized user's account
    code = params["code"]
    if code
      user = Instagram.get_access_token(code, :redirect_uri => REDIRECT_URI)
      session[:user_token] = user.access_token
      redirect_to :show
    end
    
    # Stores and displays any authorization error
    @error = params["error_reason"]
    if @error == 'user_denied'
      @error = "You Denied the Authorization! Please Try Again"
    end
  end
  
  def show
    # Gets and displays the user's media feed
    client = Instagram.client(:access_token => session[:user_token])
    @user = client.user
    @media = client.user_recent_media
  end
  
  def logout
    # Clears the cached user data
    session[:user_token] = nil
    redirect_to '/'
  end
end
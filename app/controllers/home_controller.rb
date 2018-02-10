class HomeController < ApplicationController
  before_action :authorized?, only: [:show]
  before_action :unauthorized?, only: [:index]
  
  def index
    @url = Instagram.authorize_url(:redirect_uri => REDIRECT_URI)
    
    code = params["code"]
    if code
      user = Instagram.get_access_token(code, :redirect_uri => REDIRECT_URI)
      session[:user_token] = user.access_token
      redirect_to :show
    end
    
    @error = params["error_reason"]
    if @error == 'user_denied'
      @error = "You Denied the Authorization! Please Try Again"
    end
  end
  
  def show
    client = Instagram.client(:access_token => session[:user_token])
    @user = client.user
    @media = client.user_recent_media
  end
  
  def logout
    session[:user_token] = nil
    redirect_to '/'
  end
  
  protected
    def authorized?
      unless session[:user_token]
        redirect_to '/'
      end
    end
    
    def unauthorized?
      if session[:user_token]
        redirect_to :show
      end
    end
end
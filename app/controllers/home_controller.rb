class HomeController < ApplicationController
  
  def index
    @url = Instagram.authorize_url(:redirect_uri => REDIRECT_URI)
    code = params["code"]
    @error = params["error_reason"]
    
    if code
      user = Instagram.get_access_token(code, :redirect_uri => REDIRECT_URI)
      session[:user_token] = user.access_token
    end
    
    if session[:user_token]
      redirect_to :show
    end
    
  end
  
  def show
    if session[:user_token] == nil
      redirect_to '/'
    end
    
    client = Instagram.client(:access_token => session[:user_token])
    @user = client.user
    @media = client.user_recent_media
  end
  
  def logout
    session[:user_token] = nil
    redirect_to '/'
  end
end

class ApplicationController < ActionController::Base
  include ActionController::Cookies

  REDIRECT_URI = "https://ror-tech-test.herokuapp.com"
  protect_from_forgery with: :exception
  
  # View authorization methods
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

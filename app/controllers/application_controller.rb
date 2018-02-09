class ApplicationController < ActionController::Base
  include ActionController::Cookies
  REDIRECT_URI = "https://ror-tech-test.herokuapp.com"
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

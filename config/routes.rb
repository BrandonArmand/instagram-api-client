Rails.application.routes.draw do
    root 'home#index'
    get '/show', to: 'home#show'
    get '/logout', to: 'home#logout'
end

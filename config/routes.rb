Rails.application.routes.draw do

  put 'set_locale/:locale', constraints: { locale: /fr/ }, to: 'locales#set'

  resources :stories do
    resources :places
    resources :characters
    resources :plots
    resources :groups

    post :change_current_story
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'stories#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

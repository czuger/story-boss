Rails.application.routes.draw do

  put 'set_locale/:locale', constraints: { locale: /fr/ }, to: 'locales#set'

  devise_for :users do
    resources :stories do
      resources :places
      resources :characters
      post :change_current_story
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'stories#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

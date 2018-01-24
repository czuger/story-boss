Rails.application.routes.draw do

  resources :places
  resources :characters
  put 'set_locale/:locale', constraints: { locale: /fr/ }, to: 'locales#set'

  resources :stories

  root 'stories#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

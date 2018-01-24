Rails.application.routes.draw do



  put 'set_locale/:locale', constraints: { locale: /fr/ }, to: 'locales#set'

  resources :places
  resources :characters

  resources :stories do
    post :change_current_story
  end

  root 'stories#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

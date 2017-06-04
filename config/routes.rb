Rails.application.routes.draw do
  resources :comments do
    collection do
      post 'ajax_post_comment'
    end
  end
  resources :posts do
    collection do
      get 'ajax_oldest_posts'
      get 'ajax_newest_posts'
    end
  end
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'

  get '/home', to: 'application#home', as: 'home'
  get '/secret', to: 'application#secret', as: 'secret'
  get '/about', to: 'application#about', as: 'about'
  get '/contact', to: 'application#contact', as: 'contact'

  # APIs for React
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :public do
        devise_for :users, controller: { sessions: "Api::V1::Public::Sessions"}
      end

      get 'posts/index', to: 'posts#index'
    end
  end
end

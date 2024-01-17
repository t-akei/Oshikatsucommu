Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to: 'public/homes#top'
  get 'search' => 'public/searches#search'
  get 'tagsearch/search' => 'public/tagsearches#search'

  scope module: :public do
    resources :posts do
      resource :bookmarks, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      resources :bookmarks, only: [:index]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:show, :index]
  end

end

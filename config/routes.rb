Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get 'searche' => 'searches#search'
  get 'search_result' => 'searches#search_result', as: :search_result


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
   resource :relationships, only:[:create, :destroy]
   get 'follows' => 'relationships#follower'
   get 'followers' => 'relationships#followed'
   member do
   get :followed, :follower
   end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

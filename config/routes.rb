Rails.application.routes.draw do
  get 'home_page/index'
  root 'home_page#index'

  resources :proposals, :only => [:create, :show, :new]
  resources :votes, :only => [:index, :create, :destroy]

  get 'search', to: 'search#proposals', as: 'search'

  get 'login', to: 'sessions#login', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/failure')

  get 'contact', to: 'info#contact'
  get 'policy', to: 'info#policy'
  get 'terms', to: 'info#policy'
end

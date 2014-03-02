FindAGuide::Application.routes.draw do

  # resources :authentications

  match '/users/toggle_ambassador', to: 'users#ambassador_toggle', via: [:put]
  match '/users/toggle_ambassador_availability', to: 'users#ambassador_availability_toggle', via: [:put]
  match '/contact_ambassador', to: 'emails#new_request', via: [:post]
  match '/reject_request', to: 'emails#reject', via: [:post]
  match '/reply', to: 'emails#reply', via: [:post]

  resources :users, only: [:edit, :update, :show] do
    resources :meetups, only: [:index, :show, :edit, :update, :create]
    resources :reviews, only: [:index, :new, :create]
    resources :specialties, only: [:create]
    resources :tours
  end




  get '/dashboard', to: 'users#dashboard'

  match '/search_results', to: 'users#index', via: [:get]

  # match 'auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
  # match 'auth/failure', to: redirect('/'), via: [:get, :post]

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  get '/be_an_ambassador', to: 'marketing#index'

  get '/thanks', to: 'marketing#thanks'

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

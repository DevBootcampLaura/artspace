Artspace::Application.routes.draw do

  root "welcome#index"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new"
  get "users/:id/manage", to: "users#manage", as: "manage"

  resources :users, except: [:new, :index]

  resources :spaces do
    resources :availabilities, only: [:new, :update]
  end

  get "spaces/:space_id/edit_availabilities", to: "availabilities#edit", as: "edit_availabilities"
  post "spaces/availabilities/update", to: "availabilities#update", as: "update_availabilities"
  resources :availabilities, only: [:create]
  resources :reservations, only: [:create, :destroy]
  get "reservations/confirmation", to: "reservations#confirmation", as: "reservations_confirmation"

  get  "spaces/:id/pic", to: "spaces#edit_pic", as: "edit_pic"
  
  post "delete_pic", to: "spaces#delete_photo"
  post "update_pic", to: "spaces#update_pic", as: "update_pic"
  resources :payments, only: [:new]
  get "payments/callback", to: "payments#callback", as: "payments_callback"
  post "payments/charge", to: "payments#charge", as: "payment_charge"
  get "payments/pos", to: "payments#pos", as: "pos"

  get "spaces/:space_id/reservations", to: "reservations#index", as: "view_reservations"

  #homepage is still welcome#index
  #not logged in home is welcome#index
  #logged in home is users#show
  #clicking on a space in the search results takes us to spaces#show

  #clicking the book it button creates a reservation, involves parsing calendar shit and talking to stripe

  #edit and create a space will be the same form




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

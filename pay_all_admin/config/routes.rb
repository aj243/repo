Rails.application.routes.draw do

devise_for :users, controllers: { passwords: 'users/passwords', confirmations: 'users/confirmations',
                                    registrations: 'users/registrations', sessions: 'users/sessions'}

    devise_scope :user do
      get 'signup', to: 'users/registrations#new'
      get 'signin', to: 'users/sessions#new'
      get 'signout', to: 'users/sessions#destroy'

    end

  resources :pages
  
  root to: 'pages#index'

  get 'users', to: 'users#index'

  resources :users do
    resources :verifications, only: [:new, :create, :show] do
      put :verify, on: :collection
    end

    member do
      put :verified_by_admin
      put :change_user_role
    end
  end

  # post 'verifications', to: 'verifications#create'

  # post 'verify', to: 'verifications#verify'



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

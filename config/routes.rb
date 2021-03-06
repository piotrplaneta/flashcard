Flashcard::Application.routes.draw do
  resources :words do
    resource :repetition, only: [:show, :update] do
      get 'asses_answer', :on => :member
    end
  end

  match 'repetition/give_next', to: 'repetitions#give_next'
  match 'repetitions/save', to: 'repetitions#save'

  mount Api::Engine => "/api"

  resources :words
  match 'words/:id/set_translation', to: 'Words#set_translation', :as => :set_translation
  match 'words/:id/from_pl/set_translation', to: 'Words#set_english_translation', :as => :set_english_translation
  match 'words/:id/from_en/set_translation', to: 'Words#set_polish_translation', :as => :set_polish_translation
  match 'words/:id/set_image', to: 'Words#set_image', :as => :set_image


  root :to => 'words#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match 'signup',  to: 'Users#new'
  match 'signin',  to: 'Sessions#new'
  match 'signout', to: 'Sessions#destroy', via: :delete

  match "/auth/:provider/callback" => "Sessions#create_from_facebook"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

LunchTimeNavi::Application.routes.draw do

  devise_for :users

  resources :congestions

  root :to => 'summary_lists#index'      

  resources :summary_lists, :only => [:index]

  resources :lunch_comments

  resources :genres

  resources :lunches

  resources :ratings

  resources :users

  resources :restaurants


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

  # for signup and user register
  match 'signedup' => 'signup#signedup'
  match 'newUserRegistered' => 'signup#newUserRegistered'
  match 'signup/signup' => 'signup#signup'
  match 'signup/signedup' => 'signup#signedup'
  match 'signup/registerNewUser' => 'signup#registerNewUser'
  match 'signup/newUserRegistered' => 'signup#newUserRegistered'

  # for summary list
  match 'lunch_comments/new2/:id' => 'lunch_comments#new2'
  match 'lunches/new2/:id' => 'lunches#new2'
  match 'restaurants/new2/:id' => 'restaurants#new2'
  match 'summary_lists/search' => 'summary_lists#search'

end

Rails.application.routes.draw do

  devise_for :users

	root 'home#index'
	
  get 'timetable/new'
  post 'timetable/create'
  get 'timetable/show/:user_id' => 'timetable#show'
  get 'timetable/edit'
  get 'timetable/update'
	post 'timetable/destroy/:tt_id' => 'timetable#destroy'

	get 'timetable/update_departments'
	get 'timetable/update_lectures_by_department'
	get 'timetable/update_lectures_by_classification'
	get 'timetable/update_classifications'
	get 'timetable/update_timetable'

  get 'classroom/index'
	get 'classroom/update_classroom'
	get 'classroom/update_building'
  get 'classroom/new'
  get 'classroom/create'
  get 'classroom/edit'
  get 'classroom/update'
  get 'classroom/destroy'

  get 'recommend/index'
	get 'recommend/update_wishbox'
  post 'recommend/result'
  get 'recommend/create'
  get 'recommend/edit'
  get 'recommend/update'
  get 'recommend/destroy'

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

Spree::Core::Engine.add_routes do

  namespace :admin do
    resource :drop_ship_settings
    resources :shipments
    resources :suppliers do
      resources :supplier_images do
        collection do
          post :update_positions
        end
      end
    end
  end
end

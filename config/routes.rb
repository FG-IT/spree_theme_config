Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :theme_configs do
      collection do
        post :clear_cache
      end
    end
  end
end

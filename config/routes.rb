# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :taxons, only: [] do
      resources :images do
        collection do
          post :update_positions
        end
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :taxons do
      resources :images
    end
  end
end
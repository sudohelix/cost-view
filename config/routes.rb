# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "spots#index"

  resources :rotations do
    collection do
      get "upload"
      post "batch_create"
    end
  end

  resources :spots do
    collection do
      get "upload"
      post "batch_create"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

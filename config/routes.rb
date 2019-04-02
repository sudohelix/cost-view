# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "spots#index"

  resources :rotations do
    collection do
      get "upload"
      get "batch_create", to: redirect("/rotations/upload")
      post "batch_create"
    end
  end

  resources :spots do
    collection do
      get "upload"
      get "batch_create", to: redirect("/spots/upload")
      post "batch_create"
    end
  end

  namespace :reports do
    namespace :rotation_reports do
      get "cpv_per_day"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# frozen_string_literal: true
Rails.application.routes.draw do
  resources :foo, only: [:create]
end

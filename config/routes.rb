# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'
  get '/exm', to: 'tests#exm'
  get '/admin', to: 'sessions#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'


  resources :subjects
  resources :questionsets
  resources :questions
  resources :users
  resources :exams
  resources :tests, only:[:index,:show]
end

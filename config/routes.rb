# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2012-2014, Sebastian Staudt

Braumeister::Application.routes.draw do

  resources :repositories, path: 'repos', only: [],
            constraints: { repository_id: /[0-9A-Za-z_-]+?\/[0-9A-Za-z_-]+/ } do
    resources :formulae, only: :browse, path: 'browse' do
      get ':letter(/:page)', action: :browse, on: :collection,
          as: :letter,
          constraints: { letter: /[A-Za-z]/, page: /\d+/, format: 'html' }
    end

    resources :formulae, only: :browse, path: 'search' do
      get '', action: :browse, on: :collection, as: :search_root,
          constraints: { format: 'html' }
      get ':search(/:page)', action: :search, on: :collection,
          as: :search,
          constraints: { page: /\d+/, search: /[^\/]+/, format: 'html' }
    end

    resources :formula, controller: :formulae, only: :show,
              constraints: { id: /.*/, format: 'html' }

    scope format: true, :constraints => { :format => 'atom' } do
      get '/feed' => 'formulae#feed', as: :feed
    end
  end

  resources :formulae, only: :browse, path: 'browse' do
    get ':letter(/:page)', action: :browse, on: :collection,
        as: :letter,
        constraints: { letter: /[A-Za-z]/, page: /\d+/, format: 'html' }
  end

  resources :formulae, only: :browse, path: 'search' do
    get '', action: :browse, on: :collection, as: :search_root,
        constraints: { format: 'html' }
    get ':search(/:page)', action: :search, on: :collection,
        as: :search,
        constraints: { page: /\d+/, search: /[^\/]+/, format: 'html' }
  end

  resources :formula, controller: :formulae, only: :show,
            constraints: { id: /.*/, format: 'html' }

  scope format: true, :constraints => { :format => 'atom' } do
    get '/feed' => 'formulae#feed', as: :feed
  end

  scope format: true, :constraints => { :format => 'xml' } do
    get '/sitemap' => 'application#sitemap', as: :sitemap
  end

  root to: 'application#index'

  get '*url', to: 'application#not_found', format: false

  delete '*url', to: 'application#forbidden', format: false
  post '*url', to: 'application#forbidden', format: false
  put '*url', to: 'application#forbidden', format: false

end

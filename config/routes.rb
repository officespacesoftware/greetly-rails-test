TodoRailsTest::Application.routes.draw do
  resources :lists do
    scope module: :lists do
      resources :tasks
    end
  end

  delete 'lists/', :to => 'lists#destroy'
  put 'lists/', :to => 'lists#update'

  root to: 'lists#index'
end

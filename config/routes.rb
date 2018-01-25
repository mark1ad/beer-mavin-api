Rails.application.routes.draw do
  resources :users
  resources :breweries do
    collection do
      get '/by_id', to: 'breweries#by_id'
    end
  end

  resources :beers do
    collection do
      get '/search', to: 'beers#search';
      get '/by_id', to: 'beers#by_id'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

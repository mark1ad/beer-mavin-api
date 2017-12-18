Rails.application.routes.draw do
  resources :beers do
    collection do
      get '/search', to: 'beers#search';
      get '/by_id', to: 'beers#by_id'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :beers do
    collection do
      get '/search', to: 'beers#search'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

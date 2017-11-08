Rails.application.routes.draw do
  resources :beers do
    collection do
      # TODO: zippy is for playing. Remove
      get '/zippy', to: 'beers#zippy'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

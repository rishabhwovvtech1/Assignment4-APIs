Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do 
    resources :users do
      collection do
        get '/typehead/:input', to: 'users#typehead'
      end
    end
  end
end

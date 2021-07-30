Rails.application.routes.draw do
  resources :articles do
    get 'approve', on: :member
  end
  devise_for :users, controllers: {
    :sessions => "api/users",
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

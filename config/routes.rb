Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create] do
        resources :user_sleep_diary, only: %i[index show] do
        end
      end
    end
  end
end

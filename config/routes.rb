Rails.application.routes.draw do
  resources :users
  resources :categories
  resources :films
  resources :lenses
  resources :images do
    collection do
      post :upload
      post :select_sheet
      post :map_fields
    end
  end
  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out
  get 'images/index'
  root 'images#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'image/:id/remove_thumbnail', to: 'images#remove_thumbnail', as: 'remove_image_thumbnail'
end

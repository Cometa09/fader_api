Rails.application.routes.draw do

	resources :faders, only: [:index, :show, :update], defaults: { format: :json }
	resources :buttons, only: [:index, :show, :update], defaults: { format: :json }
	post "buttons/:id/update_status", to: "buttons#update"
	resources :elements, only: [:index, :show, :update], defaults: { format: :json }
	resources :knobs, only: [:index, :show, :update], defaults: { format: :json }
	resources :displays, only: [:index, :show, :update], defaults: { format: :json }
	resources :eq_sliders, only: [:index, :show, :update]#, defaults: { format: :json }
	resources :meters, only: [:index, :show, :update], defaults: { format: :json }

  # Defines the root path route ("/")
  # root "articles#index"
end

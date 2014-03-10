Capp::Application.routes.draw do

	resources :users do
		member do
			get :siguiendo_a, :seguido_por
		end
	end
	resources :microposts, only: [:create, :destroy] do
		collection do
			get 'countNews'
			get 'listMicropostaddressees'
		end
	end

	resources :articles do
		collection do
			get 'listArticleaddressees'
		end
	end
    
	resources :sessions, 				only: [:new, :create, :destroy]
	resources :relationships,			only: [:create, :destroy]
    resources :micropostaddressees
    resources :articleaddressees
    resources :password_resets

	root to: 'static_pages#inicio'

	match '/signup',		to: 'users#new'
	match '/signin',		to: 'sessions#new'
	match '/signout',		to: 'sessions#destroy', via: :delete
	match '/ayuda', 		to: 'static_pages#ayuda'
	match '/nosotros',		to: 'static_pages#nosotros'
	match '/contacto',		to: 'static_pages#contacto'

end
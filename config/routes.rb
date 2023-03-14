Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Root route
  root to: "pages#home"

  # Devise routes
  # devise_for :users do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  #   # get '/users/sign_up' => 'users/registrations#new'
  #   # post '/users/sign_up' => 'users/registrations#create'
  # end

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  # Condition routes
  get 'list_moods' => 'conditions#list_moods'
  post 'list_moods' => 'conditions#create_condition'

  get 'list_energy' => 'conditions#list_energy'
  post 'list_energy' => 'conditions#update_condition_energy'

  get 'list_symptoms' => 'conditions#list_symptoms'
  post 'list_symptoms' => 'conditions#update_condition_symptom'

  get 'recap' => 'conditions#recap'
  post 'recap' => 'conditions#update_condition_recipe'

  # Recipe routes
  get '/recipes/:id/show_detailed', to: 'recipes#show_detailed', as: 'show_detailed'
  get '/recipes/:id/shop_list', to: 'recipes#shop_list', as: 'shop_list'
  resources :recipes, only: %i[show index]
  get '/recipes/:id' => 'recipes#recipes_proposal'
  get '/recipes/:id/steps', to: 'steps#index', as: 'recipe_steps'
  get '/recipes/:id/infos' => 'infos#show', as: 'recipe_infos'

  # Pages routes
  get '/menu', to: 'pages#menu'
  get '/home', to: 'pages#home'
end

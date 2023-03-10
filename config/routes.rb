Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Root route
  root to: "pages#menu"

  # Devise routes
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Form routes
  get 'list_moods' => 'conditions#list_moods'
  post 'list_moods' => 'conditions#create_condition'

  get 'list_energy' => 'conditions#list_energy'
  post 'list_energy' => 'conditions#update_condition_energy'

  get 'list_symptoms' => 'conditions#list_symptoms'
  post 'list_symptoms' => 'conditions#update_condition_symptom'

  # Recipe routes
  get '/recipes/:id/show_detailed', to: 'recipes#show_detailed', as: 'show_detailed'
  resources :recipes, only: %i[show index]
  get '/recipes/:id' => 'recipes#recipes_proposal'
  get '/recipes/:id/steps', to: 'steps#index', as: 'recipe_steps'
  get '/recipes/:id/infos' => 'infos#show', as: 'recipe_infos'

  # Pages routes
  get '/menu', to: 'pages#menu'
  get '/home', to: 'pages#home'
end

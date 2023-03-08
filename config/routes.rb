Rails.application.routes.draw do
  root to: "pages#menu"
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # get '/question1' => 'conditions#question1'
  # get '/question2' => 'conditions#question2'
  # get '/question3' => 'conditions#question3'
  # get '/question4' => 'conditions#question4'

  # post '/question1' => 'conditions#create_condition'
  get 'list_moods' => 'conditions#list_moods'
  post 'list_moods' => 'conditions#create_condition'

  get 'list_energy' => 'conditions#list_energy'
  post 'list_energy' => 'conditions#update_condition_energy'

  get 'list_symptoms' => 'conditions#list_symptoms'
  post 'list_symptoms' => 'conditions#update_condition_symptom'

  get '/recipes/:id/show_detailed', to: 'recipes#show_detailed', as: 'show_detailed'
  resources :recipes, only: %i[show index]
  get '/recipes/:id' => 'recipes#recipes_proposal'
  get '/recipes/:id/steps', to: 'steps#index', as: 'recipe_steps'
  get '/recipes/:id/infos' => 'infos#show'
  get '/menu', to: 'pages#menu'
end

Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/question1' => 'conditions#question1'
  get '/question2' => 'conditions#question2'
  get '/question3' => 'conditions#question3'

  get '/recipes/:id/show_detailed' => 'recipes#show_detailed'
  resources :recipes, only: %i[show index]
  get '/recipes/:id' => 'recipes#recipes_proposal'
  get '/recipes/:id/steps' => 'steps#index'
  get '/recipes/:id/infos' => 'infos#show'
end

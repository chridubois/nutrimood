Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/question1' => 'condition#question1
  '

end

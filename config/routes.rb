NcsPii::Application.routes.draw do
  get 'signup/new' => 'sign_up#new'
  post 'signup/create' => 'sign_up#create'
  root :to => "sign_up#new"
end

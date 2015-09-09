Basem::Application.routes.draw do
  resources :evaluations


  resources :providers


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "admin#index"
end

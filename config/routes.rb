Basem::Application.routes.draw do
  # resources :evaluations
  # resources :providers

  get 'evaluations/student/:access_code', to: 'evaluations#show_student'
  get 'evaluations/provider/:access_code', to: 'evaluations#show_provider'

  put 'evaluations/student/:access_code', to: 'evaluations#student_submit'
  put 'evaluations/provider/:access_code', to: 'evaluations#provider_submit'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "admin#index"
end

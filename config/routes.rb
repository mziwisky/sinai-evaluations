SinaiEvaluations::Application.routes.draw do
  # resources :evaluations
  # resources :providers

  get 'evaluations/student/:access_code', to: 'evaluations#show_student', as: 'student_evaluation'
  get 'evaluations/provider/:access_code', to: 'evaluations#show_provider', as: 'provider_evaluation'

  put 'evaluations/student/:access_code', to: 'evaluations#student_submit'
  put 'evaluations/provider/:access_code', to: 'evaluations#provider_submit'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "admin#index"
end

SinaiEvaluations::Application.routes.draw do

  get 'students/:access_code/profile',              to: 'students#edit_profile', as: 'student_edit_profile'
  put 'students/:access_code/profile',              to: 'students#update_profile', as: 'student_update_profile'

  get 'students/:access_code',                      to: 'students#new_evaluation', as: 'student_new_evaluation'
  post 'students/:access_code/evaluations',         to: 'students#create_evaluation', as: 'student_create_evaluation'
  # get 'students/:access_code/evaluations',          to: 'students#evaluations_index', as: 'student_evaluations_index'

  get 'providers/:access_code',                     to: 'providers#home', as: 'provider_home'
  get 'providers/:access_code/eval/:id',            to: 'providers#show_evaluation', as: 'provider_show_evaluation'
  # get 'providers/:access_code/eval/:id/edit',       to: 'providers#edit_evaluation', as: 'provider_edit_evaluation'
  put 'providers/:access_code/eval/:id',            to: 'providers#submit_evaluation', as: 'provider_submit_evaluation'

  # Legacy stuff -- support links from old emails
  get 'evaluations/student/:access_code',           to: 'legacy_evaluations#show_student', as: 'legacy_student_evaluation'
  get 'evaluations/provider/:access_code',          to: 'legacy_evaluations#show_provider', as: 'legacy_provider_evaluation'

  # resources :students, only: [] do
  #   resource :profile, only: [:edit, :update]
  #   resources :evaluations, only: [:index, :new, :create]
  # end
  #
  # resources :providers, only: [:show] do
  #   resources :evaluations, only: [:show, :update]
  # end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: redirect('/admin')
end

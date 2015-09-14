def status_tag_bool(bool)
  if bool
    status_tag 'yes', :ok
  else
    status_tag 'no'
  end
end

ActiveAdmin.register Evaluation do
  config.sort_order = 'created_at_desc'

  actions :all, except: [:edit]

  scope :all, default: true
  scope :unfinished
  scope :waiting_on_student
  scope :waiting_on_provider
  scope :finished

  # TODO: probably allow some filters
  config.filters = false

  # creation form
  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :student_name, as: :string
      f.input :student_email, as: :email
    end
    f.actions
  end

  # index page
  index do
    selectable_column
    column :student_name
    column :student_email
    column 'Student Finished?' do |ev|
      status_tag_bool ev.student_finished?
    end
    column :provider
    column 'Provider Finished?' do |ev|
      status_tag_bool ev.evaluator_finished?
    end
    column :created_at
    actions
  end
end

def status_tag_bool(bool)
  if bool
    status_tag 'yes', :ok
  else
    status_tag 'no'
  end
end

ActiveAdmin.register Evaluation do
  config.sort_order = 'created_at_desc'

  actions :all, except: [:new, :edit]

  scope :all, default: true
  scope :unfinished
  scope :waiting_on_student
  scope :waiting_on_provider
  scope :finished

  filter :student
  filter :provider
  filter :created_at
  filter :updated_at

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
    column :student
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

  # show page
  show do
    attributes_table do
      row :student
      row :provider
      row :evaluation do |ev|
        data = JSON.parse(ev.evaluation)
        table do
          thead do
            tr do
              th 'Metric'
              th 'Rating'
            end
          end
          tbody do
            data.each do |rating|
              tr do
                td rating['title']
                td rating['grade']
              end
            end
          end
        end
      end
      row :comments
      row :created_at
      row :updated_at
      row :provider_access_code
    end
  end
end

ActiveAdmin.register Student do
  config.sort_order = 'name_asc'

  filter :name
  filter :email
  filter :type
  filter :hospital
  filter :created_at

  index do
    selectable_column
    column :name
    column :created_at
    column :type
    column :hospital
    column :evaluations do |student|
      num_evals = student.evaluations.count
      str = (num_evals == 1 ? '1 Evaluation' : "#{num_evals} Evaluations")
      link_to str, admin_evaluations_path(q: { student_id_eq: student.id})
    end
    actions
  end

  # creation form
  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, as: :string
      f.input :email, as: :string
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :type
      row :hospital
      row :access_code
      row :created_at
      row :updated_at
      row :avatar do |student|
        image_tag student.avatar_url if student.avatar_url.present?
      end
    end
  end
end

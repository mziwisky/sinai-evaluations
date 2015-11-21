ActiveAdmin.register Student do
  config.sort_order = 'name_asc'

  index do
    selectable_column
    column :name
    column :email
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
end

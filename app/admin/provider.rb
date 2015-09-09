ActiveAdmin.register Provider do

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, as: :string
      f.input :email, as: :email
      f.input :disabled, label: 'Disabled (disabled providers cannot be selected by students to do evaluations)'
    end
    f.actions
  end
end

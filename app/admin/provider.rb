ActiveAdmin.register Provider do
  config.sort_order = 'name_asc'

  scope :active, default: true
  scope :disabled
  scope :all

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, as: :string
      f.input :email, as: :email
      f.input :disabled, hint: 'disabled providers cannot be selected by students to do evaluations'
    end
    f.actions
  end

  index do
    selectable_column
    column :name
    column :email
    column :disabled if params['scope'] == 'all'
    actions
  end
end

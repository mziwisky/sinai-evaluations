class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.text :student_name
      t.text :student_email
      t.text :student_type
      t.text :hospital
      t.text :evaluation
      t.text :student_access_code
      t.text :provider_access_code
      t.references :provider

      t.timestamps
    end
  end
end

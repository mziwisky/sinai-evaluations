class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.text :name
      t.text :email
      t.text :type
      t.text :hospital
      t.text :access_code

      t.timestamps
    end

    add_column :evaluations, :student_id, :integer
    add_index :evaluations, :student_id
    add_index :evaluations, :provider_id

    Evaluation.all.each do |e|
      student = Student.where(email: e.student_email).first
      unless student
        student = Student.new(
          name: e.student_name,
          email: e.student_email,
          type: e.student_type,
          hospital: e.hospital,
          access_code: SecureRandom.uuid
        )
        student.inhibit_emails = true
        student.save!
      end
      e.student = student
      e.save!
    end

    remove_column :evaluations, :student_name
    remove_column :evaluations, :student_email
    remove_column :evaluations, :student_type
    remove_column :evaluations, :hospital
  end

  def down
    add_column :evaluations, :student_name, :text
    add_column :evaluations, :student_email, :text
    add_column :evaluations, :student_type, :text
    add_column :evaluations, :hospital, :text

    Evaluation.all.each do |e|
      student = e.student
      e.student_name = student.name
      e.student_email = student.email
      e.student_type = student.type
      e.hospital = student.hospital
      e.save!
    end

    remove_column :evaluations, :student_id
    remove_index :evaluations, :provider_id

    drop_table :students
  end
end

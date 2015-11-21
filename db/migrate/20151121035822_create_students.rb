class CreateStudents < ActiveRecord::Migration
  def change
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
      attrs = {
        name: e.student_name,
        email: e.student_email,
        type: e.student_type,
        hospital: e.hospital,
        access_code: e.student_access_code
      }
      student = Student.where(email: e.student_email).first
      unless student
        student = Student.new(attrs)
        student.inhibit_emails = true
        student.save!
      end
      e.student = student
      e.save!
    end

    %i[student_name student_email student_type hospital student_access_code].each do |c|
      remove_column :evaluations, c
    end
  end
end

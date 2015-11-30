class StudentMailer < ActionMailer::Base
  default from: "sinai.evaluations@gmail.com"

  def welcome_email(student)
    @student = student
    @url = student_new_evaluation_url(access_code: student.access_code)
    mail(to: student.email, subject: "Sinai/HCH Student Evaluation Portal Access")
  end
end

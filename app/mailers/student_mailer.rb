class StudentMailer < ActionMailer::Base
  default from: "sinai.evaluations@gmail.com"

  def welcome_email(student)
    @student = student
    @url = student_evaluation_url(access_code: student.access_code)
    mail(to: student.email, subject: "ACTION REQUIRED: Sinai Health Systems Student Evaluation")
  end
end

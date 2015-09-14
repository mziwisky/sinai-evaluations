class EvaluationMailer < ActionMailer::Base
  default from: "chicago.student.eval@gmail.com"

  def student_email(evaluation)
    @evaluation = evaluation
    @url = student_evaluation_url(access_code: evaluation.student_access_code)
    mail(to: evaluation.student_email, subject: "ACTION REQUIRED: Sinai Health Systems Student Evaluation")
  end

  def provider_email(evaluation)
    @evaluation = evaluation
    @url = provider_evaluation_url(access_code: evaluation.provider_access_code)
    mail(to: evaluation.provider.email, subject: "ACTION REQUIRED: Student Evaluation for #{evaluation.student_name}")
  end
end

class ProviderMailer < ActionMailer::Base
  default from: "sinai.evaluations@gmail.com"

  def new_evaluation_email(evaluation)
    @evaluation = evaluation
    @url = provider_evaluation_url(access_code: evaluation.provider_access_code)
    mail(to: evaluation.provider.email, subject: "ACTION REQUIRED: Student Evaluation for #{evaluation.student_name}")
  end
end

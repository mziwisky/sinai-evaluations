class ProviderMailer < ActionMailer::Base
  default from: "sinai.evaluations@gmail.com"

  def new_evaluation_email(evaluation)
    @evaluation = evaluation
    @url = provider_show_evaluation_url(access_code: evaluation.provider.access_code, evaluation_id: evaluation.id)
    mail(to: evaluation.provider.email, subject: "ACTION REQUIRED: Student Evaluation for #{evaluation.student.name}")
  end
end

class LegacyEvaluationsController < ApplicationController
  def show_student
    evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    student = evaluation.student
    redirect_to student_new_evaluation_path(access_code: student.access_code)
  end

  def show_provider
    evaluation = Evaluation.where(provider_access_code: params[:access_code]).first or not_found
    provider = evaluation.provider
    redirect_to provider_show_evaluation_path(
      access_code: provider.access_code,
      id: evaluation.id)
  end
end

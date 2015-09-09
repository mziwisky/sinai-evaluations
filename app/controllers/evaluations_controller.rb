class EvaluationsController < ApplicationController
  def show_student
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    @providers = Provider.where(disabled: false)
    @student_types = [
      ['M3', 'M3'],
      ['M4', 'M4'],
      ['Physician Assistant', 'PA']]
    @hospitals = [
      ['Mount Sinai', 'Mount Sinai'],
      ['Holy Cross', 'Holy Cross'],
    ]
  end

  def show_provider
    @evaluation = Evaluation.where(provider_access_code: params[:access_code]).first or not_found
  end

  def student_submit
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    @evaluation.update_attributes(params[:evaluation])
    render text: params[:evaluation].to_json
  end

  private

  def not_found
    raise ActiveRecord::RecordNotFound
  end
end

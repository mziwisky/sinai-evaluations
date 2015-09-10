class EvaluationsController < ApplicationController
  def show_student
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    prepare_student_form_vars
  end

  def student_submit
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    @evaluation.student_update(params[:evaluation])

    if @evaluation.valid?
      # TODO: redirect to a view page or something
      render text: "thanks! -- #{params[:evaluation].to_json}"
    else
      prepare_student_form_vars
      render 'show_student'
    end
  end

  def show_provider
    @evaluation = Evaluation.where(provider_access_code: params[:access_code]).first or not_found
  end

  def provider_submit
    # TODO:
  end

  private

  def prepare_student_form_vars
    @providers = Provider.where(disabled: false)
    @student_types = [
      ['M3', 'M3'],
      ['M4', 'M4'],
      ['Physician Assistant', 'PA']]
    @hospitals = [
      ['Condell Hospital', 'Condell'],
      ['Stroger Hospital', 'Stroger'],
      ['Ross Medical School', 'Ross'],
      ['Mount Sinai Hospital', 'Mount Sinai'],
      ['Holy Cross Hospital', 'Holy Cross'],
    ]
  end

  def not_found
    raise ActiveRecord::RecordNotFound
  end
end

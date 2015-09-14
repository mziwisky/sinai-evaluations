class EvaluationsController < ApplicationController
  def show_student
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    prepare_student_form_vars
  end

  def student_submit
    @evaluation = Evaluation.where(student_access_code: params[:access_code]).first or not_found
    # TODO: more elegant error check here
    render 'show_student' and return if @evaluation.student_finished?

    @evaluation.student_update(params[:evaluation])

    if @evaluation.valid?
      @just_submitted = true
      render 'show_student'
    else
      prepare_student_form_vars
      render 'show_student'
    end
  end

  def show_provider
    @evaluation = Evaluation.where(provider_access_code: params[:access_code]).first or not_found
    @rubric = @evaluation.rubric
  end

  # this one's kinda nasty...
  def provider_submit
    @evaluation = Evaluation.where(provider_access_code: params[:access_code]).first or not_found
    @rubric = @evaluation.rubric
    render 'show_provider' and return if @evaluation.evaluator_finished?

    @rubric.apply_grades!(params[:rubric])
    @evaluation.comments = params[:evaluation][:comments]

    if @rubric.completed?
      @evaluation.evaluator_update(@rubric)
      @just_submitted = true
      render 'show_provider'
    else
      @rubric.mark_errors!
      render 'show_provider'
    end
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

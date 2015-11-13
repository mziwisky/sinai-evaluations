class EvaluationsController < ApplicationController
  before_filter :fetch_student_evaluation, only: %i[show_student student_submit]
  before_filter :fetch_provider_evaluation, only: %i[show_provider provider_submit]

  def show_student
    prepare_student_form_vars
  end

  def student_submit
    render 'show_student' and return if @evaluation.student_finished?

    @evaluation.student_update(params[:evaluation])

    if @evaluation.valid?
      EvaluationMailer.provider_email(@evaluation).deliver
      @just_submitted = true
      render 'show_student'
    else
      prepare_student_form_vars
      render 'show_student'
    end
  end

  def show_provider
    @rubric = @evaluation.rubric
  end

  # this one's kinda nasty...
  def provider_submit
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

  def fetch_student_evaluation
    id = params[:access_code]
    @evaluation = if id == 'demo'
                    Evaluation.new(student_name: 'Demo Student')
                  else
                    Evaluation.where(student_access_code: id).first or not_found
                  end
  end

  def fetch_provider_evaluation
    id = params[:access_code]
    @evaluation = if id == 'demo'
                    Evaluation.new(student_name: 'Demo Student').tap do |e|
                      e.provider = Provider.new(name: 'Demo Provider')
                    end
                  else
                    Evaluation.where(provider_access_code: params[:access_code]).first or not_found
                  end
  end

  def prepare_student_form_vars
    @providers = Provider.where(disabled: false)
    @student_types = [
      ['M3 Ross', 'M3 Ross'],
      ['M3 CMS', 'M3 CMS'],
      ['M4 Ross', 'M4 Ross'],
      ['M4 CMS', 'M4 CMS'],
      ['PA RFUMS', 'PA RFUMS'],
      ['PA Midwestern', 'PA Midwestern'],
      ['Resident FM', 'Resident FM'],
      ['Resident Peds', 'Resident Peds']]
    @hospitals = [
      ['HOLY CROSS Hospital', 'Holy Cross'],
      ['Mount Sinai Hospital', 'Mount Sinai']]
  end

  def not_found
    raise ActiveRecord::RecordNotFound
  end
end

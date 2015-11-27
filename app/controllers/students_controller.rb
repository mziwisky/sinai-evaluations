class StudentsController < ApplicationController

  before_filter :fetch_student, only: %i[edit_profile update_profile new_evaluation create_evaluation evaluations_index]

  def edit_profile
    prepare_student_form_vars
  end

  def update_profile
    @student.student_update(params[:student])

    if @student.valid?
      flash[:notice] = "Profile updated."
      redirect_to student_new_evaluation_path
    else
      prepare_student_form_vars
      flash[:alert] = "You've got some issues there, friend."
      render 'edit_profile'
    end
  end

  def new_evaluation
    unless @student.profile_complete?
      flash[:notice] = "Please complete your profile. You only have to do this once."
      redirect_to student_edit_profile_path
    end
    @evaluation = Evaluation.new
    @providers = Provider.where(disabled: false)
  end

  def create_evaluation
    @evaluation = Evaluation.create(create_eval_params)
    if @evaluation.valid?
      ProviderMailer.new_evaluation_email(@evaluation).deliver
      flash[:notice] = "Evaluation request sent to #{@evaluation.provider.name}"
      # redirect_to student_evaluations_index_path
      redirect_to student_new_evaluation_path
    else
      render 'new_evaluation'
    end
  end

  def evaluations_index
    @evaluations = Evaluation.where(student: @student)
  end

  private

  def create_eval_params
    {
      provider_id: params[:evaluation][:provider_id],
      student_id: @student.id
    }
  end

  def fetch_student
    id = params[:access_code]
    @student = if id == 'demo'
                 Student.new(name: 'Demo Student')
               else
                 Student.where(access_code: id).first or not_found
               end
  end

  def prepare_student_form_vars
    # @providers = Provider.where(disabled: false)
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
      ['Holy Cross Hospital', 'Holy Cross'],
      ['Mount Sinai Hospital', 'Mount Sinai']]
  end
end

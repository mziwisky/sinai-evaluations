class ProvidersController < ApplicationController
  before_filter :fetch_provider
  before_filter :fetch_evaluation, only: %i[show_evaluation submit_evaluation]

  def home
    @evaluations = @provider.outstanding_evaluations
  end

  def show_evaluation
    @rubric = @evaluation.rubric
    if @evaluation.finished?
      render 'show_evaluation'
    else
      render 'edit_evaluation'
    end
  end

  def submit_evaluation
    @rubric = @evaluation.rubric
    render 'show_evaluation' and return if @evaluation.finished?

    @rubric.apply_grades!(params[:rubric])
    @evaluation.comments = params[:evaluation][:comments]

    if @rubric.completed?
      @evaluation.evaluator_update(@rubric)
      flash.now[:notice] = "Thanks, your evaluation has been recorded"
      render 'show_evaluation'
    else
      @rubric.mark_errors!
      flash.now[:alert] = "I think you missed a spot"
      render 'edit_evaluation'
    end
  end

  private

  def fetch_provider
    @provider ||= Provider.where(access_code: params[:access_code]).first or not_found
  end

  def fetch_evaluation
    fetch_provider
    @evaluation = Evaluation.where(id: params[:id]).first
    if @evaluation.blank? || @evaluation.provider_id != @provider.id
      flash[:alert] = "That evaluation couldn't be located, but here's a list of your outstanding evals"
      redirect_to provider_home_path(access_code: @provider.access_code)
    end
    # TODO: allow demoing for admin page
    # @evaluation = if id == 'demo'
    #                 Evaluation.new(student_name: 'Demo Student').tap do |e|
    #                   e.provider = Provider.new(name: 'Demo Provider')
    #                 end
    #               else
    #                 Evaluation.where(provider_access_code: id).first or not_found
    #               end
  end
end

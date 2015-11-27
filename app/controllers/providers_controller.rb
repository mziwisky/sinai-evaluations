class ProvidersController < ApplicationController
  before_filter :fetch_evaluation, only: %i[show_evaluation submit_evaluation]

  def home
    provider_id = Provider.where(access_code: params[:access_code]).pluck(:id).first
    not_found unless provider_id.present?
    @evaluations = Evaluation.where(provider_id: provider_id)
  end

  def show_evaluation
    # TODO: redirect to home with a flash message like "that evaluation couldn't be found, but here's your homepage, dawg"
  end

  def submit_evaluation
  end

  private

  def fetch_evaluation
    @evaluation = Evaluation.find(params[:evaluation_id])
    not_found if @evaluation.provider.access_code != params[:access_code]
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

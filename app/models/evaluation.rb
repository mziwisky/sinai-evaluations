class Evaluation < ActiveRecord::Base
  attr_accessible :evaluation, :comments, :provider_id, :student_id
  belongs_to :provider
  belongs_to :student

  scope :unfinished, where(evaluation: nil)
  scope :finished, where('evaluation IS NOT NULL')

  validates_presence_of :student, :provider

  def evaluator_update(rubric)
    self.evaluation = rubric.to_json
    save
  end

  # did the provider finish evaluating the student?
  def finished?
    persisted_attribute(:evaluation).present?
  end

  def rubric
    @rubric ||= if persisted_attribute(:evaluation).present?
                  Rubric.new(JSON.parse(evaluation))
                else
                  Rubric.new
                end
  end

  private

  def persisted_attribute(attr)
    if send "#{attr}_changed?".to_sym
      send "#{attr}_was".to_sym
    else
      send attr.to_sym
    end
  end
end

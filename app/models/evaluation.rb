class Evaluation < ActiveRecord::Base
  attr_accessible :student_email, :student_name, :student_type, :hospital, :evaluation, :provider_id, :comments
  belongs_to :provider

  attr_accessor :student_submission
  validates_presence_of :student_email, :student_name
  validates_presence_of :student_type, :hospital, :provider_id, :if => lambda { self.student_submission }

  before_create :generate_access_codes

  after_create :send_email_to_student

  scope :unfinished, lambda { where(evaluation: nil) }
  scope :waiting_on_student, lambda { where(provider_id: nil) }
  scope :waiting_on_provider, lambda { where('provider_id IS NOT NULL AND evaluation IS NULL') }
  scope :finished, lambda { where('provider_id IS NOT NULL AND evaluation IS NOT NULL') }

  def student_update(attrs)
    self.student_submission = true
    update_attributes(attrs)
  end

  def evaluator_update(rubric)
    self.evaluation = rubric.to_json
    save
  end

  # did the student finish filling out the basic info?
  def student_finished?
    persisted_attribute(:provider_id).present?
  end

  # did the provider finish evaluating the student?
  def evaluator_finished?
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

  def generate_access_codes
    self.student_access_code = SecureRandom.uuid
    self.provider_access_code = SecureRandom.uuid
  end

  def send_email_to_student
    EvaluationMailer.student_email(self).deliver
  end
end

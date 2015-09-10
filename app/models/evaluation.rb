class Evaluation < ActiveRecord::Base
  attr_accessible :student_email, :student_name, :student_type, :hospital, :evaluation, :provider_id
  belongs_to :provider

  attr_accessor :student_submission, :evaluator_submission
  validates_presence_of :student_email, :student_name
  validates_presence_of :student_type, :hospital, :provider_id, :if => lambda { self.student_submission }
  validates_presence_of :evaluation, :if => lambda { self.evaluator_submission }

  before_create :generate_access_codes

  after_create :send_email_to_student

  def student_update(attrs)
    self.student_submission = true
    update_attributes(attrs)
  end

  def evaluator_update(attrs)
    self.evaluator_submission = true
    update_attributes(attrs)
  end

  private

  def generate_access_codes
    self.student_access_code = SecureRandom.uuid
    self.provider_access_code = SecureRandom.uuid
  end

  def send_email_to_student
  end
end

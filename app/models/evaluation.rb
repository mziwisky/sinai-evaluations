class Evaluation < ActiveRecord::Base
  attr_accessible :student_email, :student_name, :student_type, :hospital, :evaluation
  belongs_to :provider

  validates_presence_of :student_email, :student_name

  before_create :generate_access_codes

  after_create :send_email_to_student

  private

  def generate_access_codes
    self.student_access_code = SecureRandom.uuid
    self.provider_access_code = SecureRandom.uuid
  end

  def send_email_to_student
  end
end

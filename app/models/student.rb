class Student < ActiveRecord::Base
  # we use 'type' as a regular attr, not for single table inheritance
  self.inheritance_column = :_type_disabled

  attr_accessible :access_code, :email, :hospital, :name, :type, :avatar_url

  has_many :evaluations, dependent: :destroy

  attr_accessor :inhibit_emails
  attr_accessor :student_submission
  validates_presence_of :email, :name
  validates_presence_of :type, :hospital, if: -> { self.student_submission }

  before_create :generate_access_code

  after_create :send_email_to_student

  def student_update(attrs)
    self.student_submission = true
    update_attributes(attrs)
  end

  def profile_complete?
    type.present? && hospital.present?
  end

  private

  def generate_access_code
    self.access_code = SecureRandom.uuid
  end

  def send_email_to_student
    StudentMailer.welcome_email(self).deliver unless inhibit_emails
  end
end

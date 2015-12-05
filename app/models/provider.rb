class Provider < ActiveRecord::Base
  attr_accessible :email, :name, :disabled

  has_many :evaluations, dependent: :destroy

  validates_presence_of :email, :name

  before_create :generate_access_code

  scope :active, where(disabled: [false, nil])
  scope :disabled, where(disabled: true)

  def outstanding_evaluations
    evaluations.unfinished
  end

  private

  def generate_access_code
    self.access_code = SecureRandom.uuid
  end
end

class Provider < ActiveRecord::Base
  attr_accessible :email, :name, :disabled

  has_many :evaluations

  validates_presence_of :email, :name

  scope :active, where(disabled: [false, nil])
  scope :disabled, where(disabled: true)

  def outstanding_evaluations
    evaluations.unfinished
  end
end

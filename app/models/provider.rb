class Provider < ActiveRecord::Base
  attr_accessible :email, :name, :disabled

  validates_presence_of :email, :name

  scope :active, lambda { where(disabled: [false, nil]) }
  scope :disabled, lambda { where(disabled: true) }
end

class Provider < ActiveRecord::Base
  attr_accessible :email, :name, :disabled

  validates_presence_of :email, :name
end

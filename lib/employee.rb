class Employee < ActiveRecord::Base
  has_many :contributions
  has_many :projects, through: :contributions
  belongs_to(:division)
end

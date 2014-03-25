class Project < ActiveRecord::Base
  has_many :contributions
  has_many :employees, through: :contributions

  def mark_done
    self.update({done: true})
  end

end

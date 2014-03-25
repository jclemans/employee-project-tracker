class Join < ActiveRecord::Migration
  def change
    create_table :employees_projects do |t|
      t.belongs_to :employees
      t.belongs_to :projects
    end
  end
end

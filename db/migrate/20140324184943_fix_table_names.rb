class FixTableNames < ActiveRecord::Migration
  def change
    rename_table :employee, :employees
    rename_table :project, :projects
    rename_table :division, :divisions

  end
end

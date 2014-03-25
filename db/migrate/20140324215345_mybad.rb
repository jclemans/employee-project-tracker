class Mybad < ActiveRecord::Migration
  def change
    rename_column :employees_projects, :employees_id, :employee_id
    rename_column :employees_projects, :projects_id, :project_id
  end
end

class RemoveEmpId < ActiveRecord::Migration
  def change
    remove_column :projects, :employee_id, :int
  end
end

class AddIds < ActiveRecord::Migration
  def change
    add_column :employee, :division_id, :int
    add_column :project, :employee_id, :int
  end
end

class Contribution < ActiveRecord::Migration
  def change
    rename_table :employees_projects, :contributions
    add_column :contributions, :desc, :string
  end
end

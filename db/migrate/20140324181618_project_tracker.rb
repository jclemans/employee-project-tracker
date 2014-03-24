class ProjectTracker < ActiveRecord::Migration
  def change
    create_table :employee do |t|
      t.column :name, :string
      t.timestamps
    end
    create_table :project do |t|
      t.column :name, :string
      t.timestamps

    end
    create_table :division do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end

class CreateComfortResources < ActiveRecord::Migration
  def change
    create_table :comfort_resources do |t|
      
      t.integer :resources_count, default: 0
      t.string :project_id, lenght: 500
      t.date :resources_by
    end
  end
end

class Jobs < ActiveRecord::Migration
  def up
    create_table :jobs do |t|      
      t.decimal :start_time, :precision => 10, :default => 0.0, :null => false
      t.decimal :end_time, :precision => 10, :default => 0.0, :null => false
      t.decimal :running_time, :precision => 10, :default => 0.0, :null => false
      t.string :name
      
      t.timestamps
    end
  end

  def down
    drop_table :data_harvest
  end
end

class DataHarvest < ActiveRecord::Migration
  def up
    create_table :data_harvests do |t|      
      t.decimal :harvest_start_time, :precision => 10, :default => 0.0, :null => false
      t.decimal :harvest_end_time, :precision => 10, :default => 0.0, :null => false
      t.text :raw_data, :null => false
      t.string :url, :null => false
      
      t.timestamps
    end
  end

  def down
    drop_table :data_harvests
  end
end

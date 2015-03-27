class EnphaseStats < ActiveRecord::Migration
  def up
    create_table :enphase_stats do |t|      
      t.integer :end_at, :null => false
      t.string :enphase_user_id, :null => false      
      t.decimal :enwh, :precision => 10, :default => 0.0, :null => false
      t.integer :system_id, :null => false
      t.boolean :valid_data_on_creation, :default => false
      
      t.timestamps
    end
  end

  def down
    drop_table :enphase_stats
  end
end

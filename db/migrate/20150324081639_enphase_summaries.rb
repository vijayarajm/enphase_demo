class EnphaseSummaries < ActiveRecord::Migration
  def up
    create_table :enphase_summaries do |t|      
      t.string :enphase_user_id, :null => false
      t.integer :energy_lifetime, :null => false
      t.integer :energy_today, :null => false
      t.integer :operational_at, :null => false
      t.integer :size_w, :null => false
      # t.foreign_key :users
      
      t.timestamps
    end
  end

  def down
    drop_table :enphase_summaries
  end
end

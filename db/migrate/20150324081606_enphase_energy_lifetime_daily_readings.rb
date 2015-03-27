class EnphaseEnergyLifetimeDailyReadings < ActiveRecord::Migration
  def up
    create_table :enphase_energy_lifetime_daily_readings do |t|
      t.string :enphase_user_id, :null => false
      t.integer :system_id, :null => false
      t.datetime :est_date, :null => false
      t.decimal :production_enwh, :precision => 10, :default => 0.0, :null => false
      t.integer :enphase_energy_lifetime_id, :null => false
      # t.foreign_key :enphase_energy_lifetime
      
      t.timestamps
    end
  end

  def down
    drop_table :enphase_energy_lifetime_daily_readings
  end
end

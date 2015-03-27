class EnphaseEnergyLifetime < ActiveRecord::Migration
  def up
    create_table :enphase_energy_lifetime do |t|
      t.string :enphase_user_id, :null => false
      t.integer :system_id, :null => false
      t.datetime :start_date, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :enphase_energy_lifetime
  end
end

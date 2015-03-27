class StatsAggregateConsumptions < ActiveRecord::Migration
  def up
    create_table :stats_aggregate_consumptions do |t|
      t.decimal :calculated_costs, :precision => 10, :default => 0.0, :null => false
      t.string :electric_provider_id, :null => false
      t.integer :enwh, :null => false
      t.integer :month, :null => false
      t.integer :year, :null => false
      t.integer :user_id, :null => false
      # t.foreign_key :users
      
      t.timestamps
    end
  end

  def down
    drop_table :stats_aggregate_consumptions
  end
end

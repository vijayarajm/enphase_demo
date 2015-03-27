class Users < ActiveRecord::Migration
  def up
    create_table :users do |t|      
      t.string :email
      t.string :enphase_auth_token
      t.string :enphase_user_id, :null => false
      t.string :gb_auth_token
      t.string :gb_user_id
      
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end

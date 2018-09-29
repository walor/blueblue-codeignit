class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name 
      t.string :maiden_name
      t.string :position
      t.string :email
      t.string :phone
      t.references :provider 
      t.timestamps
    end
  end
end

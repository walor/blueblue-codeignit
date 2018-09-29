class CreateSettingMains < ActiveRecord::Migration
  def change
    create_table :setting_mains do |t|
      t.string :name
      t.string :ruc
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end

class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :resposible
      t.string :ruc

      t.timestamps
    end
  end
end

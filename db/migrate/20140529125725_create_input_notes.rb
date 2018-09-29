class CreateInputNotes < ActiveRecord::Migration
  def change
    create_table :input_notes do |t|
      t.string :name
      t.references :provider
      t.date :date
      t.float :sub_total, default: 0
      t.float :total, default: 0
      t.integer :status
      t.integer :emisor_id
      t.integer :receiver_id
      t.string :doc_ref
      t.string :invoice_number
      t.datetime :invoice_date
      t.references :ware_house

      t.timestamps
    end
  end
end

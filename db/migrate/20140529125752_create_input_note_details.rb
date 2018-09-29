class CreateInputNoteDetails < ActiveRecord::Migration
  def change
    create_table :input_note_details do |t|
      t.references :input_note
      t.references :product
      t.string :product_name
      t.text :product_description #esto se esta usando para el detalle
      t.float :quantity, default: 1
      t.float :price_unit, default: 0
      t.float :price_total, default: 0
      t.integer :outgoing, default: 0
      t.timestamps
    end
    add_index :input_note_details, :input_note_id
    add_index :input_note_details, :product_id
  end
end
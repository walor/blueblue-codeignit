class AddOperationTypeToInputNotePurchaseOrdern < ActiveRecord::Migration
  def change
    add_column :movements, :document_type, :integer
    add_column :requeriment_items, :detail, :text
    add_column :input_notes, :movement_type_id, :integer
    add_column :input_notes, :type_input_note, :integer
    add_column :input_notes, :document_type, :integer
    add_column :input_notes, :area_origin_id, :integer
    add_column :input_notes, :area_destination_id, :integer
    add_column :input_notes, :destination, :string
    add_column :purchase_orders, :document_type, :integer
    add_column :purchase_orders, :movement_type_id, :integer
    add_column :input_note_details, :brand_id, :integer, references: :brands
    add_column :input_note_details, :model, :string
    add_column :input_note_details, :detail, :string
  end
end
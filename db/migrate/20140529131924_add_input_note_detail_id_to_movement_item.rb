class AddInputNoteDetailIdToMovementItem < ActiveRecord::Migration
   def change
    add_column :movement_items, :input_note_detail_id, :integer, references: :input_note_details
  end

end

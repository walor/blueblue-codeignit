class AddInputNoteIdToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :input_note_id, :integer, references: :input_notes
  end
end

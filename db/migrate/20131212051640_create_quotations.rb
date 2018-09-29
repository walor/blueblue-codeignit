class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :name
      t.references :provider
      t.boolean :completed, default: false
      t.text :observations
      t.string :quotation_provider_number
      t.string :validity
      t.string :delivery
      t.string :pay_form

      t.timestamps
    end
    add_index :quotations, :provider_id
  end
end

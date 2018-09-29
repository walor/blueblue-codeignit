class InputNoteDetail < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :input_note, inverse_of: :input_note_details
  belongs_to :product
  belongs_to :brand
  after_update :update_input_note
  attr_accessor :category_id, :sub_group_id, :group_id
  attr_accessible :price_total, :price_unit, :product_id, :product_description, :product_name, :quantity, :outgoing, :category_id, :sub_group_id, :group_id, :brand_id, :model, :detail

  def group_id
    product.group_id unless product.nil?
  end

  def sub_group_id
    product.sub_group_id unless product.nil?
  end

  def category_id
    product.category_id unless product.nil?
  end

  def price_total
    price_unit * quantity
  end

  private

  def update_input_note
    if outgoing_changed?
      total_pending = input_note.input_note_details.pluck(:quantity).reduce(:+)
      total_incoming = input_note.input_note_details.pluck(:outgoing).reduce(:+)

      if total_incoming = total_pending
        input_note.update_column(:status, InputNote::DISPATCHED)
      else
        input_note.update_column(:status, InputNote::PENDING)
      end
    end
  end

end
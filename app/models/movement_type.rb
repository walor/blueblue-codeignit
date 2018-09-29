class MovementType < ActiveRecord::Base
  attr_accessible :name, :signal, :type_process
  scope :incoming, ->(){ where("signal != ? and id != ? ", -1, 2) }
  scope :incoming_purchase, ->(){ where("id = ?  ", 2) }
  scope :get_out, ->(){ where(signal: -1) }
  scope :get_out_normal, ->(){ where("signal = ? and id != ? ", -1, 3 ) }
end

class OperationType < ActiveRecord::Base
  attr_accessible :name, :type_process

  scope :by_process, ->(type_process) {where("type_process = ?", type_process)}
end

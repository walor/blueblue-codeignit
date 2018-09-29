class Agent < ActiveRecord::Base
  belongs_to :provider
  attr_accessible :first_name, :last_name, :maiden_name, :position, :phone, :email
end

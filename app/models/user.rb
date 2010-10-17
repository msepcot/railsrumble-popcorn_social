class User < ActiveRecord::Base
  has_many :messages
  has_many :viewings
  
  before_create :setup_uuid
  
private
  def setup_uuid
    self.uuid = UUIDTools::UUID.timestamp_create.to_s
  end
end

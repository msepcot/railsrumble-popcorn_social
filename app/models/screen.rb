class Screen < ActiveRecord::Base
  belongs_to :video
  has_many :messages
  has_many :viewings
  has_many :users, :through => :viewings
  
  after_create :setup_uuid
  
private
  def setup_uuid
    update_attributes :uuid => id.to_s(32).rjust(4, '0')
  end
end

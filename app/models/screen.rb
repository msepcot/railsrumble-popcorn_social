class Screen < ActiveRecord::Base
  belongs_to :video
  has_many :messages
  has_many :viewings
  has_many :users, :through => :viewings
  
  attr_accessor :delay
  
  after_create :setup_uuid
  
  DelayOptions = [['Start Immediately', 0], ['One Minute Delay', 1], ['Two Minute Delay', 2], ['Five Minute Delay', 5], ['Ten Minute Delay', 10]]
  
  scope :public, where(:private => false)
  
private
  def setup_uuid
    update_attributes :uuid => id.to_s(32).rjust(4, '0')
  end
end

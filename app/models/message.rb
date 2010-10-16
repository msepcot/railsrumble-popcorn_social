class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :screen
  has_one    :video, :through => :screen
end

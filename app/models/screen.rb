class Screen < ActiveRecord::Base
  has_one  :video
  has_many :messages
  has_many :viewings
  has_many :users, :through => :viewings
end

class Note < ActiveRecord::Base
  belongs_to :video
  default_scope where(:deleted => nil)
end

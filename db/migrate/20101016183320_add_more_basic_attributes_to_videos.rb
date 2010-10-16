class AddMoreBasicAttributesToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :thumbnail, :string
    add_column :videos, :featured, :bool
    add_column :videos, :external_rating, :int
    add_column :videos, :description, :text
  end

  def self.down
    remove_column :videos, :description
    remove_column :videos, :external_rating
    remove_column :videos, :featured
    remove_column :videos, :thumbnail
  end
end

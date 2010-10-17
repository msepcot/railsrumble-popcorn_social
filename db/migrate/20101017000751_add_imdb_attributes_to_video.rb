class AddImdbAttributesToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :poster, :string
    add_column :videos, :tagline, :text
    add_column :videos, :certification, :string
    add_column :videos, :runtime, :string
    add_column :videos, :released_on, :timedate
    add_column :videos, :imdb_rating, :int
    add_column :videos, :imdb_id, :string
    add_column :videos, :deleted, :boolean
  end

  def self.down
    remove_column :videos, :deleted
    remove_column :videos, :imdb_id
    remove_column :videos, :imdb_rating
    remove_column :videos, :released_on
    remove_column :videos, :runtime
    remove_column :videos, :certification
    remove_column :videos, :tagline
    remove_column :videos, :poster
  end
end

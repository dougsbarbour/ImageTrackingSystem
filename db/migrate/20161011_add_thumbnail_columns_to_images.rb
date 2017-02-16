class AddThumbnailColumnsToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :thumbnail
  end

  def self.down
    remove_attachment :images, :thumbnail
  end
end
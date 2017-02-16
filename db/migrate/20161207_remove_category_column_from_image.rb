class RemoveCategoryColumnFromImage < ActiveRecord::Migration
  def change
    remove_column :images, :category
  end
end
class AddCategoryReferencesToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :category, foreign_key: true
  end
end

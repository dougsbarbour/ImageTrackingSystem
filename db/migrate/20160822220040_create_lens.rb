class CreateLens < ActiveRecord::Migration[5.0]
  def change
    create_table :lenses do |t|
      t.string :description

      t.timestamps
    end
  end
end

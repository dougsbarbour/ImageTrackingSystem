class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :category
      t.string :idSuffix
      t.string :description
      t.string :location
      t.string :description2
      t.date :dateTaken
      t.date :dateEntered
      t.string :orientation
      t.string :keywords
      t.string :notes
      t.belongs_to :lens
      t.belongs_to :film

      t.timestamps
    end
  end
end

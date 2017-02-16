class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.attachment :current_upload_file

      t.timestamps
    end
  end
end

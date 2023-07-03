class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :fisrt_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :is_admin, default: false
      t.string :password_digest

      t.timestamps
    end
  end
end

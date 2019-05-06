class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :username
      t.string :consoles
      t.string :games
    end
  end
end

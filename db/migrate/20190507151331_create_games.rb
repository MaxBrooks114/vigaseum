class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
        t.string :name
        t.string :developer
        t.string :genre
        t.integer :review
        t.date :date_added
        t.integer :console_id
        t.integer  :user_id
    end
  end
end

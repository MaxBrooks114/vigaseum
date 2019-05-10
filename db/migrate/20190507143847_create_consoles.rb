class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
        t.string :name
        t.string :company
        t.date :date_added
        t.integer :generation
        t.integer  :user_id
    end
  end
end

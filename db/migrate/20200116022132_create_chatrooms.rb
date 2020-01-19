class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.integer :genre
      t.integer :target
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateToppages < ActiveRecord::Migration[5.2]
  def change
    create_table :toppages do |t|

      t.timestamps
    end
  end
end

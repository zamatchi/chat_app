class RenameHistoryColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :history, :profile
  end
end

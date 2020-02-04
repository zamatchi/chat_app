class AddBestanswerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :bestanswer, :integer
  end
end
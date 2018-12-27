class AddColumnToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :hint, :string
  end
end

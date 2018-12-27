class CreateCategoryQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :category_questions do |t|
      t.integer :category_id
      t.integer :question_id

      t.timestamps
    end
  end
end

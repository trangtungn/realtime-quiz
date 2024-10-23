class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :description
      t.string :token
      t.datetime :expired_at

      t.timestamps
    end

    add_index :quizzes, :token, unique: true
  end
end

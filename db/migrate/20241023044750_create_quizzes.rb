class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :description
      t.string :token
      t.datetime :start_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :expired_at
      t.references :creator, null: false, foreign_key: { to_table: :users }


      t.timestamps
    end

    add_index :quizzes, :token, unique: true
  end
end

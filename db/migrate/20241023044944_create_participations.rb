class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end

    add_index :participations, [:user_id, :quiz_id], unique: true
  end
end

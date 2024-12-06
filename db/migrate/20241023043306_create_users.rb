class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :type, default: "User"

      t.timestamps
    end

    add_index :users, :type
  end
end

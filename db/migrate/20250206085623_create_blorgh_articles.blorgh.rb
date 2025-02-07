# This migration comes from blorgh (originally 20241121134408)
class CreateBlorghArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :blorgh_articles do |t|
      t.string :title, null: false, limit: 128
      t.text :text, null: false
      t.bigint :created_by, null: false

      t.timestamps
    end
  end
end


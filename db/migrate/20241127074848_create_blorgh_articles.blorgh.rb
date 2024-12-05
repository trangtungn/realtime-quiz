# This migration comes from blorgh (originally 20241121134408)
class CreateBlorghArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :blorgh_articles do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end

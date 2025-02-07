# This migration comes from blorgh (originally 20241126115801)
class CreateBlorghComments < ActiveRecord::Migration[7.1]
  def change
    create_table :blorgh_comments do |t|
      t.references :blorgh_article, null: false, foreign_key: { on_delete: :cascade }
      t.text :text, null: false
      t.bigint :created_by, null: false

      t.timestamps
    end
  end
end

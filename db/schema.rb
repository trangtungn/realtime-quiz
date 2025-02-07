# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_06_085624) do
  create_table "blorgh_articles", force: :cascade do |t|
    t.string "title", limit: 128, null: false
    t.text "text", null: false
    t.bigint "created_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blorgh_comments", force: :cascade do |t|
    t.integer "blorgh_article_id", null: false
    t.text "text", null: false
    t.bigint "created_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blorgh_article_id"], name: "index_blorgh_comments_on_blorgh_article_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_participations_on_quiz_id"
    t.index ["user_id", "quiz_id"], name: "index_participations_on_user_id_and_quiz_id", unique: true
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "token"
    t.datetime "start_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "expired_at"
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_quizzes_on_creator_id"
    t.index ["token"], name: "index_quizzes_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "type", default: "User"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["type"], name: "index_users_on_type"
  end

  add_foreign_key "blorgh_comments", "blorgh_articles", on_delete: :cascade
  add_foreign_key "participations", "quizzes"
  add_foreign_key "participations", "users"
  add_foreign_key "quizzes", "users", column: "creator_id"
end

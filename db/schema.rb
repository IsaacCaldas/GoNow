# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_06_175233) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "description"
    t.integer "likes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "main_comment_id"
    t.bigint "post_id"
    t.bigint "user_id"
    t.index ["main_comment_id"], name: "index_comments_on_main_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "viewed"
    t.bigint "chat_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "likes", default: 0
    t.string "img_url"
    t.bigint "theme_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_posts_on_theme_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_chats", force: :cascade do |t|
    t.bigint "chat_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_user_chats_on_chat_id"
    t.index ["user_id"], name: "index_user_chats_on_user_id"
  end

  create_table "user_comment_likes", force: :cascade do |t|
    t.boolean "liked"
    t.bigint "user_id"
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_user_comment_likes_on_comment_id"
    t.index ["user_id"], name: "index_user_comment_likes_on_user_id"
  end

  create_table "user_post_likes", force: :cascade do |t|
    t.boolean "liked"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_user_post_likes_on_post_id"
    t.index ["user_id"], name: "index_user_post_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "nickname"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "posts", "themes"
  add_foreign_key "posts", "users"
  add_foreign_key "user_chats", "chats"
  add_foreign_key "user_chats", "users"
  add_foreign_key "user_comment_likes", "comments"
  add_foreign_key "user_comment_likes", "users"
  add_foreign_key "user_post_likes", "posts"
  add_foreign_key "user_post_likes", "users"
end

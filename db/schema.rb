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

ActiveRecord::Schema.define(version: 2019_05_07_134730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_locations_on_project_id"
  end

  create_table "locations_users", id: false, force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "user_id", null: false
    t.index ["location_id", "user_id"], name: "index_locations_users_on_location_id_and_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
  end

  create_table "projects_roles", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "role_id", null: false
    t.index ["project_id", "role_id"], name: "index_projects_roles_on_project_id_and_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.bigint "role_id"
    t.index ["project_id"], name: "index_templates_on_project_id"
    t.index ["role_id"], name: "index_templates_on_role_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email"
    t.index ["invitation_token"], name: "index_users_on_invitation_token"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

end

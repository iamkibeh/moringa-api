

ActiveRecord::Schema[7.0].define(version: 2023_01_21_190521) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.boolean "agreement"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "twitter_url"
    t.string "cv_url"
    t.string "profile_img"
    t.string "cover_img"
    t.string "country"
    t.string "bio"
    t.string "profession"
    t.string "user_type"
    t.string "company_name"
    t.string "company_website"
    t.string "user_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

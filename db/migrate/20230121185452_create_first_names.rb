class CreateFirstNames < ActiveRecord::Migration[7.0]
  def change
    create_table :first_names do |t|
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :email
      t.string :password_digest
      t.boolean :agreement
      t.string :github_url
      t.string :linkedin_url
      t.string :twitter_url
      t.string :cv_url
      t.string :profile_img
      t.string :cover_img
      t.string :country
      t.string :bio
      t.string :profession
      t.string :user_type
      t.string :company_name
      t.string :company_website
      t.string :user_location

      t.timestamps
    end
  end
end

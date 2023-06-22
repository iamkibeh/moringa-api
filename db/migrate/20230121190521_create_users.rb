class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false
      t.string :phone_number
      t.string :password_digest
      t.boolean :agreement
      t.string :github_url
      t.string :linkedin_url
      t.string :twitter_url
      t.string :cv_url
      t.string :country
      t.string :bio
      t.string :profession, default: ["Developer"], array: true
      t.string :user_type
      t.string :company_name
      t.string :company_website
      t.string :user_location
      t.string :username
      t.string :portfolio_url

      t.timestamps
    end
  end
end

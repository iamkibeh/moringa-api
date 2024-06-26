source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.4"
# ruby "3.1.0"  

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

#  secure_password
gem 'jwt'
gem 'bcrypt', '~> 3.1.12'
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# For ActiveModel::Serializers
gem 'active_model_serializers'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

# active storage for file uploads [https://edgeguides.rubyonrails.org/active_storage_overview.html]
gem "image_processing", "~> 1.2"
gem 'ruby-vips', '~> 2.1', '>= 2.1.4'
gem 'mini_magick', '~> 4.11', '>= 4.11.0'

# azure storage blob for active storage 
gem "azure-storage-blob", require: false

# Use Redis adapter to run Action Cable in production [https://edgeguides.rubyonrails.org/action_cable_overview.html#deployment]
gem "redis", "~> 4.0"

# Use action cable for real time updates [https://edgeguides.rubyonrails.org/action_cable_overview.html]
gem "actioncable", "~> 7.0.4"

# background jobs [https://edgeguides.rubyonrails.org/active_job_basics.html] 
gem "sidekiq", "~> 6.2", ">= 6.2.2"

gem "hiredis"

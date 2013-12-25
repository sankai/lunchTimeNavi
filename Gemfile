source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#----------------- for Heroku start ---------------------#
#gem 'sqlite3', group: [:development, :test]
#gem 'pg', group: :production
# 

#gem 'heroku'

group :production, :staging do
  #gem "pg"       # heroku 
  gem "mysql2", '= 0.3.11'    # 1go1nen
  # gem "activerecord-mysql2-adapter" # 1go1nen
end

group :development, :test do
  gem "sqlite3-ruby", :require => "sqlite3"
end

#group :production do
#  gem 'thin'
#end

#----------------- for Heroku end ------------------------#

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  #gem 'jquery-ui-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-ui-rails'

gem 'jquery-rails'

gem 'will_paginate', '~>3.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'carrierwave'  

# for pagination
gem 'will_paginate', '~> 3.0'  

# for cloudinary
gem 'cloudinary'	# heroku only

# for clean logs
# gem 'rails-clean-logs', :git => 'git://github.com/lucas-clemente/rails-clean-logs.git' # heroku only

# Devise
gem 'devise'


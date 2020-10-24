# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Networking
gem 'http', '~>4.0'

# Testing
gem 'minitest', '~>5.0'
gem 'minitest-rg', '~>5.0'
gem 'simplecov', '~>0'

# Code Quality
gem 'flog'
gem 'reek'
gem 'rubocop'

# Utilities
gem 'rake'

group :development, :test do
    gem 'vcr'
    gem 'webmock'
end

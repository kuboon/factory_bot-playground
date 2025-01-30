require 'active_record'
require 'factory_bot'
require 'sqlite3'

# Setup SQLite3 in-memory database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define User and Group ActiveRecord models
class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
end

class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
end

# Create database schema for users, groups, and groups_users tables
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
    t.timestamps
  end

  create_table :groups do |t|
    t.string :name
    t.timestamps
  end

  create_table :groups_users, id: false do |t|
    t.belongs_to :user
    t.belongs_to :group
  end
end

# Write FactoryBot definitions for User and Group models
FactoryBot.define do
  factory :user do
    name { "John Doe" }
  end

  factory :group do
    name { "Admins" }
  end
end

# Add FactoryBot.create for both User and Group factories
user = FactoryBot.create(:user)
group = FactoryBot.create(:group)

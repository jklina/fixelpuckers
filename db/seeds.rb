# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'user' }, 
  { :name => 'VIP' }
], :without_protection => true)

puts 'SETTING UP DEFAULT USER LOGIN'

user = User.new :name => 'First User', 
                :email => 'user@example.com',
                :password => 'please',
                :password_confirmation => 'please'
user.username = 'user1'
user.save!
user.confirm!
puts 'New user created: ' << user.name

user2 = User.new :name => 'Second User',
                 :email => 'user2@example.com',
                 :password => 'please',
                 :password_confirmation => 'please'
user2.username = 'user2'
user2.save!
user2.confirm!
puts 'New user created: ' << user2.name

user.add_role :admin
user2.add_role :VIP

submission = Submission.new :title => 'Sub1',
                            :description => 'This is a submission'
submission.user = user
submission.save!
puts 'New submission created: ' << submission.title

submission2 = Submission.new :title => 'Sub2',
                             :description => 'This is another submission2'
submission2.user = user2
submission2.save!
puts 'New submission2 created: ' << submission2.title

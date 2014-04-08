# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# puts 'CREATING ROLES'
puts 'SETTING UP DEFAULT USER LOGIN'

user = User.new :name => 'First User', 
                :email => 'user@example.com',
                :password => 'password'
user.username = 'user1'
user.save!
puts 'New user created: ' << user.name

user2 = User.new :name => 'Second User',
                 :email => 'user2@example.com',
                 :password => 'password'
user2.username = 'user2'
user2.save!
puts 'New user created: ' << user2.name

user.add_role :admin
user2.add_role :VIP

12.times.each do |n|
  submission = Submission.new :title => "Sub#{n}",
                              :description => 'This is a submission'
  submission.author = user
  submission.save!
  puts 'New submission created: ' << submission.title
end


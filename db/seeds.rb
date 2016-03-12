# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do |i|
  user = User.new(
    name: "User" + i.to_s,
    email: "user" + i.to_s + "@dev.com",
    password: "password",
    password_confirmation: "password"
  )
  user.save
end

random_num = Random.new

100.times do |i|
    post = Post.new(
      content: "A post created via seed",
      user: User.find(random_num.rand(1..50))
      )
    post.save
  end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Devise::Mailer.perform_deliveries = false

def generate_user(full_name, email, password, status)
  new_user = User.create(full_name: full_name, email: email, password: password, password_confirmation: password, status: status)
  new_user.confirm
end

puts "# ============================================================================================================= #"
puts "# ---------------------------------------- >> START SEEDING  << ----------------------------------------------- #"
puts "# ============================================================================================================= #"

puts "# ---------------------------------------- >> CREATE Authors  << ------------------------------------ #"
generate_user("mohamed hammad", "m.hammad@news.com", "password", "author")
generate_user("dan abramov", "d.abramov@news.com", "password", "author")
generate_user("ahmed elghandour", "a.elghandour@news.com", "password", "author")
generate_user("sameh deabes", "s.deabes@news.com", "password", "author")

puts "# ---------------------------------------- >> CREATE Admin  << ------------------------------------ #"
generate_user("Michael hardy", "michael@news.com", "password", "admin")

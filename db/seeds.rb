# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Devise::Mailer.perform_deliveries = false

def generate_user(full_name, email, password, role)
  new_user = User.create(full_name: full_name, email: email, password: password, password_confirmation: password, role: role)
  new_user.confirm
end

def generate_article(title, description, author, status)
  Article.create(title: title, description: description, user_id: author, status: status)
end

puts "# ============================================================================================================= #"
puts "# ---------------------------------------- >> START SEEDING  << ----------------------------------------------- #"
puts "# ============================================================================================================= #"

puts "# ---------------------------------------- >> CREATE Authors  << ------------------------------------ #"
generate_user("mohamed hammad", "m.hammad@news.com", "password", "author")
generate_user("dan abramov", "d.abramov@news.com", "password", "author")
generate_user("ahmed elghandour", "a.elghandour@news.com", "password", "author")
generate_user("sameh deabes", "s.deabes@news.com", "password", "author")
puts "# ---------------------------------------- >> DONE WITH Authors  << ------------------------------------ #"

puts "# ---------------------------------------- >> CREATE Admin  << ------------------------------------ #"
generate_user("Michael hardy", "michael@news.com", "password", "admin")
puts "# ---------------------------------------- >> DONE WITH Admin  << ------------------------------------ #"

puts "# ---------------------------------------- >> CREATE Articles  << ------------------------------------ #"
generate_article("OOP VS FUNCTIONAL PROGRAMMING", "Functional programming and object-oriented programming uses different method for storing and manipulating the data. In functional programming, data cannot be stored in objects, and it can only be transformed by creating functions. In object-oriented programming, data is stored in objects.", 1, "published")

generate_article("Before You memo()", "There are many articles written about React performance optimizations. In general, if some state update is slow, you need to: Verify you’re running a production build. (Development builds are intentionally slower, in extreme cases even by an order of magnitude.)", 2, "published")

generate_article("he Huffington Post", "The history of political blogging might usefully be divided into the periods pre- and post-Huffington. Before the millionaire socialite Arianna Huffington decided to get in on the act, bloggers operated in a spirit of underdog solidarity. They hated the mainstream media - and the feeling was mutual.", 3, "pending")

generate_article("Boing Boing", "The history of political blogging might usefully be divided into the periods pre- and post-Huffington. Before the millionaire socialite Arianna Huffington decided to get in on the act, bloggers operated in a spirit of underdog solidarity. They hated the mainstream media - and the feeling was mutual.", 3, "pending")

generate_article(" Techcrunch", "The history of political blogging might usefully be divided into the periods pre- and post-Huffington. Before the millionaire socialite Arianna Huffington decided to get in on the act, bloggers operated in a spirit of underdog solidarity. They hated the mainstream media - and the feeling was mutual.", 4, "rejected")

generate_article("How To Write ReadME", "The history of political blogging might usefully be divided into the periods pre- and post-Huffington. Before the millionaire socialite Arianna Huffington decided to get in on the act, bloggers operated in a spirit of underdog solidarity. They hated the mainstream media - and the feeling was mutual.", 4, "pending")

puts "# ---------------------------------------- >> DONE WITH Articles  << ------------------------------------ #"






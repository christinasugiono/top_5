require "open-uri"
require "nokogiri"
require "faker"

Point.destroy_all
Contribution.destroy_all
BoardHashtag.destroy_all
Hashtag.destroy_all
Bookmark.destroy_all
Board.destroy_all
User.destroy_all

puts "Creating users"
christina = User.create!(username: "christina", email: "christina@gmail.com", password: "123123")
daniel = User.create!(username: "daniel", email: "daniel@gmail.com", password: "123123")
rayhan = User.create!(username: "rayhan", email: "rayhan@gmail.com", password: "123123")

100.times do
  username = Faker::Name.name.downcase.gsub(" ", "")
  User.create!(username: username, email: "#{username}@gmail.com", password: "123123")
end

puts "#{User.count} users created"

puts "Scraping thetoptens.com"
url = 'https://www.thetoptens.com/lists/'
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

# 1..17
(1..17).each do |id|
  html_doc.search("#catgrid > div:nth-child(#{id}) > a").each do |element|
    category = element.text.strip
    new_category = Hashtag.create(title: category.downcase)

    category_url = element.attribute('href').value
    category_file = URI.open(category_url).read
    category_doc = Nokogiri::HTML(category_file)

    puts "Opening #{category_url}"
    category_doc.search(".listgrid > a").each do |element|
      top_list = element.children[0..1].text.strip
      top_list.gsub!("Top 10 ", "")
      top_list.gsub!("Top ten ", "")
      top_list.gsub!("Top Ten ", "")
      user_board = User.all.sample
      new_board = Board.create(title: top_list, description: "Top 5 #{top_list}", user: user_board)
      BoardHashtag.create(board: new_board, hashtag: new_category)

      top_list_url = element.attribute('href').value
      top_list_file = URI.open(top_list_url).read
      top_list_doc = Nokogiri::HTML(top_list_file)

      puts "Scraping Top 5 #{top_list}"
      top_list_doc.search("b").each do |element|
        if element.text.strip != ""
          user_contribution = [user_board, user_board, User.all.sample].sample
          list = element.text.strip
          Contribution.create(name: list, description: list, user: user_contribution, board: new_board)
        end
      end
    end
  end
end

puts "Creating Boards"
travel = Board.create!(title: "safest place to travel", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina)
coding = Board.create!(title: "coding language to learn", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina)
activities = Board.create!(title: "activities in Bali", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel)
cheapest = Board.create!(title: "cheapest countries to travel", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel)
crypto = Board.create!(title: "crypto to invest", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan)
restaurants = Board.create!(title: "restaurants in Canggu", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan)

puts "#{Board.count} Boards created"

puts "Creating Contributions"
Contribution.create!(name: "Bali", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: travel)
Contribution.create!(name: "Singapore", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: travel)
Contribution.create!(name: "Melbourne", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: travel)
Contribution.create!(name: "Tulum Mexico", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: travel)
Contribution.create!(name: "Spain", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: travel)
Contribution.create!(name: "Ruby", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: coding)
Contribution.create!(name: "Python", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: coding)
Contribution.create!(name: "Javascript", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: coding)
Contribution.create!(name: "Dart", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: coding)
Contribution.create!(name: "Golang", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: christina, board: coding)
Contribution.create!(name: "Surf", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: activities)
Contribution.create!(name: "Yoga", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: activities)
Contribution.create!(name: "Beachclub", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: activities)
Contribution.create!(name: "Meditation", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: activities)
Contribution.create!(name: "Party", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: activities)
Contribution.create!(name: "Vietnam", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: cheapest)
Contribution.create!(name: "Costa Rica", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: cheapest)
Contribution.create!(name: "Bulgaria", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: cheapest)
Contribution.create!(name: "Mexico", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: cheapest)
Contribution.create!(name: "Indonesia", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: daniel, board: cheapest)
Contribution.create!(name: "Bitcoin", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: crypto)
Contribution.create!(name: "Ethereum", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: crypto)
Contribution.create!(name: "Solana", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: crypto)
Contribution.create!(name: "Cardano", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: crypto)
Contribution.create!(name: "Avalanche", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: crypto)
Contribution.create!(name: "Warung Sika", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: restaurants)
Contribution.create!(name: "Penny Lane", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: restaurants)
Contribution.create!(name: "Smoke", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: restaurants)
Contribution.create!(name: "Touche", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: restaurants)
Contribution.create!(name: "Dua Tiga", description: "Lorem ipsum dolor, sit amet consectetur adipisicing elit.", user: rayhan, board: restaurants)

puts "#{Contribution.count} Contributions created"

puts "Creating Hashtags"
travel_hashtag = Hashtag.create!(title: "travel")
backpack_hashtag = Hashtag.create!(title: "backpack")
vacation_hashtag = Hashtag.create!(title: "vacation")
study_hashtag = Hashtag.create!(title: "study")
coding_hashtag = Hashtag.create!(title: "coding")
restaurant_hashtag = Hashtag.create!(title: "restaurant")
eat_hashtag = Hashtag.create!(title: "eat")
food_hashtag = Hashtag.create!(title: "food")
cheap_hashtag = Hashtag.create!(title: "cheap")

puts "#{Hashtag.count} Hashtags created"

puts "Creating Board Hashtags"
BoardHashtag.create!(board: travel, hashtag: travel_hashtag)
BoardHashtag.create!(board: travel, hashtag: backpack_hashtag)
BoardHashtag.create!(board: travel, hashtag: vacation_hashtag)
BoardHashtag.create!(board: coding, hashtag: study_hashtag)
BoardHashtag.create!(board: coding, hashtag: coding_hashtag)
BoardHashtag.create!(board: activities, hashtag: travel_hashtag)
BoardHashtag.create!(board: cheapest, hashtag: travel_hashtag)
BoardHashtag.create!(board: cheapest, hashtag: cheap_hashtag)
BoardHashtag.create!(board: cheapest, hashtag: backpack_hashtag)
BoardHashtag.create!(board: restaurants, hashtag: food_hashtag)
BoardHashtag.create!(board: restaurants, hashtag: eat_hashtag)
BoardHashtag.create!(board: restaurants, hashtag: restaurant_hashtag)

puts "#{BoardHashtag.count} Board Hashtags created"

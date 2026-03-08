puts "SEED START"

categories = [
  "Новости",
  "Обучение",
  "Разработка",
  "Безопасность"
]

categories.each do |name|
  category = Category.find_or_create_by!(name: name)
  puts "CREATED: #{category.name}"
end

puts "SEED END"

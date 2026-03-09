# frozen_string_literal: true

puts 'SEED START'

categories = %w[
  Новости
  Обучение
  Разработка
  Безопасность
]

categories.each do |name|
  category = Category.find_or_create_by!(name: name)
  puts "CREATED: #{category.name}"
end

puts 'SEED END'

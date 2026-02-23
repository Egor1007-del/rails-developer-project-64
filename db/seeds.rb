categories = [
  "Новости",
  "Обучение",
  "Разработка",
  "Безопасность"
]
categories.each do |name|
  Category.find_or_create_by!(name: name)
end

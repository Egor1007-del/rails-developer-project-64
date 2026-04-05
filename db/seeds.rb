# frozen_string_literal: true

puts 'SEED START'

# == Categories ==

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

# == Users ==

users = Array.new(5) do |i|
  user = User.find_or_create_by!(email: "user#{i + 1}@test.com") do |u|
    u.password = 'Password!123'
  end

  puts "CREATED USER: #{user.email}"
  user
end

# == Posts ==

posts = Array.new(20) do |i|
  post = Post.create!(
    title: "Тестовый пост ##{i + 1}",
    body: "Это тестовый текст поста номер #{i + 1}. " * 5,
    category: Category.all.sample,
    creator: users.sample
  )
  puts "CREATED POST: #{post.title}"
  post
end

# == Comments ==

posts.each do |post|
  root_comment = Array.new(rand(3..6)) do |i|
    comment = post.comments.create!(
      content: "Комментарий #{i + 1} к посту #{post.id}",
      user: users.sample
    )

    puts "CREATED COMMENT ##{comment.id} FOR POST ##{post.id}"
    comment
  end

  root_comment.each do |parent_comment|
    Array.new(rand(0..2)) do |i|
      child_comment = post.comments.create!(
        content: "Ответ #{i + 1} на комментарий #{parent_comment.id}",
        user: users.sample,
        parent: parent_comment
      )
      puts "CREATED REPLY ##{child_comment.id} FOR COMMENT ##{parent_comment.id}"
    end
  end
end

puts 'SEED END'

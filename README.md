[![CI](https://github.com/Egor1007-del/rails-developer-project-64/actions/workflows/ci.yml/badge.svg)](https://github.com/Egor1007-del/rails-developer-project-64/actions)
[![Hexlet Check](https://github.com/Egor1007-del/rails-developer-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Egor1007-del/rails-developer-project-64/actions)
[![Render](https://img.shields.io/badge/Render-Deployed-success)](https://rails-developer-project-64.onrender.com)

# Rails Developer Project

## 📌 Описание проекта

Веб-приложение на Ruby on Rails для публикации постов с возможностью:
- регистрации и аутентификации пользователей
- создания и просмотра постов
- категоризации контента
- взаимодействия с постами (например, лайки / комментарии — если есть)

Проект реализован в рамках обучения и демонстрирует базовые практики разработки на Rails:
- MVC-архитектура
- работа с базой данных через ActiveRecord
- тестирование
- CI/CD
- деплой на Render

---

## 🚀 Демо

👉 [https://rails-developer-project-64.onrender.com](https://rails-developer-project-64.onrender.com)

---

## 🛠️ Технологии

- Ruby
- Ruby on Rails
- PostgreSQL
- Devise (аутентификация)
- Bootstrap
- Minitest (указать свой вариант)
- RuboCop + Slim-Lint
- GitHub Actions (CI)

---

## ⚙️ Установка и запуск

### 1. Клонирование репозитория

```bash
git clone https://github.com/Egor1007-del/rails-developer-project-64.git
cd rails-developer-project-64
```

### 2. Установка зависимостей

```bash
bundle install
yarn install
```

### 3. Настройка базы данных

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Запуск проекта

```bash
make render-start
```

### 5. Тесты

```bash
make test
```

### 6. Линтеры

```bash
make lint
```

## 📌 Примеры

### Создание поста

- Авторизуйтесь

- Перейдите в форму создания поста

- Заполните поля

- Сохраните

## 📄 Лицензия

MIT
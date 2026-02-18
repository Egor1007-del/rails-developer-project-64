PORT?=3000
RACK_ENV?=development

render-build:
	bundle install
	yarn install
	bundle exec rails assets:precompile
	bundle exec rails assets:clean
	bundle exec rails db:migrate

render-start:
	bundle exec puma -t 5:5 -p ${PORT} -e ${RACK_ENV}

lint:
	bin/rubocop -f github
	bundle exec slim-lint app/views
test:
	RAILS_ENV=test bin/rails db:test:prepare test test:system

ci: lint test
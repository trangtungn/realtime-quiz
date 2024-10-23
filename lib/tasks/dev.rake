namespace :dev do
  desc 'Load development fixtures'
  task load_fixtures: :environment do
    ActiveRecord::FixtureSet.create_fixtures('test/fixtures', ['users', 'quizzes'])
  end
end

class User < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :quizzes, through: :participations
end

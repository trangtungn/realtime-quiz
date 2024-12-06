class Admin < User
  has_many :created_quizzes, class_name: "Quiz", foreign_key: :creator_id, dependent: :destroy
end

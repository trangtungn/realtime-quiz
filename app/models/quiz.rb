class Quiz < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :participations, dependent: :destroy

  validates :token, presence: true, uniqueness: true
  validates :token, length: { is: 8 }

  before_validation :set_default_start_at, on: :create
  before_validation :generate_token, on: :create
  before_create :set_expiration

  def expired?
    expired_at < Time.current
  end

  private

  def set_default_start_at
    self.start_at ||= created_at || Time.current
  end

  # TODO: Improve token generation not to query the database
  def generate_token
    loop do
      self.token = SecureRandom.urlsafe_base64(6)
      break unless Quiz.exists?(token: token)
    end
  end

  def set_expiration
    self.expired_at ||= 2.days.from_now
  end
end

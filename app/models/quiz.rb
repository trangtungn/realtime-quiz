class Quiz < ApplicationRecord
  has_many :participations, dependent: :destroy

  before_validation :generate_token, on: :create
  before_create :set_expiration

  def expired?
    expired_at < Time.current
  end

  private

  def generate_token
    self.token = loop do
      token = SecureRandom.uuid
      break token unless self.class.exists?(token:)
    end
  end

  def set_expiration
    self.expired_at = 2.days.from_now
  end
end

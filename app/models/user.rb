class User < ApplicationRecord
  after_create :send_welcome_email

  belongs_to :company

  scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }
  scope :by_username, -> (username) { where('UPPER(username) LIKE UPPER(?)', "%#{username}%") if username.present? }

  private

  def send_welcome_email
    UserMailer.welcome_email(self)
  end
end

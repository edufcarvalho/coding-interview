class User < ApplicationRecord
  belongs_to :company

  scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }
  scope :by_username, -> (username) { where('UPPER(username) LIKE UPPER(?)', "%#{username}%") if username.present? }
end

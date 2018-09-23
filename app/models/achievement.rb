class Achievement < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  enum privacy: %i[public_access private_access friends_access]
end

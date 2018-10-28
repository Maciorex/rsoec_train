class Achievement < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true, uniqueness: { scope: :user_id }
  enum privacy: %i[public_access private_access friends_access]

  def silly_title
    title + ' by ' + user.email
  end

  def self.by_letter(letter)
    includes(:user).where('title LIKE ?', "#{letter}%").order('users.email')
  end

  def self.get_public_achievements

  end
end

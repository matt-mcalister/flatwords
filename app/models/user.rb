class User < ApplicationRecord
  has_many :board_users
  has_many :boards, through: :board_users

end

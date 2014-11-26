class User < ActiveRecord::Base
  has_many :casks

  validates :login, presence: true
end

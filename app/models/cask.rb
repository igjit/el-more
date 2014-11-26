class Cask < ActiveRecord::Base
  belongs_to :user
  has_many :cask_packages
  has_many :packages, through: :cask_packages

  validates :url, presence: true
  validates :raw_url, presence: true
end

class Package < ActiveRecord::Base
  belongs_to :cask
  has_many :cask_packages
  has_many :casks, through: :cask_packages

  validates :name, presence: true
  validates :repo_type, presence: true
end

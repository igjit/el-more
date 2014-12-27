class Cask < ActiveRecord::Base
  belongs_to :user
  has_many :cask_packages, dependent: :delete_all
  has_many :packages, through: :cask_packages

  validates :url, presence: true
  validates :raw_url, presence: true

  def path
    URI(url).path.split('/').values_at(2, 5..-1).join('/')
  end
end

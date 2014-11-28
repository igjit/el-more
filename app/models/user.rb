class User < ActiveRecord::Base
  has_many :casks

  validates :login, presence: true

  scope :using_cask_for_configuration, -> { where('casks.configuration' => true).joins(:casks).uniq(:id) }
end

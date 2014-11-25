class CaskPackage < ActiveRecord::Base
  belongs_to :cask
  belongs_to :package
end

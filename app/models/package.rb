class Package < ActiveRecord::Base
  include Redis::Objects

  belongs_to :cask
  has_many :cask_packages
  has_many :casks, through: :cask_packages

  validates :name, presence: true
  validates :repo_type, presence: true

  sorted_set :similarity

  def similar_packages(limit: nil)
    end_index = limit.nil? ? -1 : limit - 1

    id_scores = similarity.revrange(0, end_index, withscores: true)
    ids = id_scores.map { |a, b| a.to_i }
    scores = id_scores.map(&:last)
    packages = Package.find(ids).index_by(&:id).slice(*ids).values

    packages.zip(scores)
  end
end

class Package < ActiveRecord::Base
  include Redis::Objects

  belongs_to :cask
  has_many :cask_packages, dependent: :delete_all
  has_many :casks, through: :cask_packages

  validates :name, presence: true
  validates :repo_type, presence: true

  sorted_set :similarity

  scope :popular, -> {
    select('packages.*, COUNT(packages.id) AS count_packages')
      .joins(:cask_packages)
      .group('packages.id')
      .order('count_packages DESC') }

  scope :added_after, ->(time) {
    popular
      .where('packages.created_at > ?', time)
      .having('COUNT(packages.id) > ?', 1)
      .reorder('created_at DESC') }

  def similar_packages(limit: nil)
    end_index = limit.nil? ? -1 : limit - 1

    id_scores = similarity.revrange(0, end_index, withscores: true)
    ids = id_scores.map { |a, b| a.to_i }
    scores = id_scores.map(&:last)
    packages = Package.find(ids).index_by(&:id).slice(*ids).values

    packages.zip(scores)
  end
end

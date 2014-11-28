module PackageSimilarityUpdater
  module_function

  def update
    cask_ids_dict = Hash[Package.includes(:casks).map { |p| [p, p.casks.map(&:id)] }]

    Package.redis.pipelined do
      Stats.roundrobin(Package.all).each do |p1, p2|
        similarity = Stats.jaccard_index cask_ids_dict[p1], cask_ids_dict[p2]

        if similarity > 0
          p1.similarity[p2.id] = similarity
          p2.similarity[p1.id] = similarity
        end
      end
    end
  end

  def delete_all
    Package.redis.flushdb
  end
end

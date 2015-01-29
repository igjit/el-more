require 'rails_helper'
require 'package_similarity_updater'

RSpec.describe PackageSimilarityUpdater do
  before :each do
    @package_a = create(:package)
    @package_b = create(:package)
    @package_c = create(:package)

    @cask_a = create(:cask)
    @cask_b = create(:cask)
    @cask_c = create(:cask)
    @cask_d = create(:cask)

    @package_a.casks = [@cask_a, @cask_b, @cask_c, @cask_d]
    @package_b.casks = [@cask_a, @cask_b]
    @package_c.casks = [@cask_c]
  end

  describe "update" do
    it "updates similarities" do
      PackageSimilarityUpdater.update

      expect(@package_a.similar_packages).to eq [[@package_b, 2.0 / 4.0],
                                                 [@package_c, 1.0 / 4.0]]
      expect(@package_b.similar_packages).to eq [[@package_a, 2.0 / 4.0]]
      expect(@package_c.similar_packages).to eq [[@package_a, 1.0 / 4.0]]
    end
  end

  describe "delete_all" do
    it "deletes all similarities" do
      PackageSimilarityUpdater.update
      PackageSimilarityUpdater.delete_all

      expect(@package_a.similar_packages).to eq []
      expect(@package_b.similar_packages).to eq []
      expect(@package_c.similar_packages).to eq []
    end
  end
end

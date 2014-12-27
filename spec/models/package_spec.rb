require 'rails_helper'

RSpec.describe Package, :type => :model do
  it { should have_many(:cask_packages).dependent(:delete_all) }
  it { should have_many(:casks).through(:cask_packages) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:repo_type) }

  describe '#similar_packages' do
    before :each do
      Redis.current.flushdb

      @package_a = create(:package)
      @package_b = create(:package)
      @package_c = create(:package)
      @package_d = create(:package)

      @package_a.similarity[@package_b.id] = 0.4
      @package_a.similarity[@package_c.id] = 0.9
      @package_a.similarity[@package_d.id] = 0.8
    end

    it { expect(@package_a.similar_packages(limit: 1)).to eq [[@package_c, 0.9]] }
    it { expect(@package_a.similar_packages(limit: 2)).to eq [[@package_c, 0.9], [@package_d, 0.8]] }
    it { expect(@package_a.similar_packages(limit: 10)).to eq [[@package_c, 0.9], [@package_d, 0.8], [@package_b, 0.4]] }
    it { expect(@package_a.similar_packages()).to eq [[@package_c, 0.9], [@package_d, 0.8], [@package_b, 0.4]] }
  end
end

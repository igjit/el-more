require 'rails_helper'

RSpec.describe Cask, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:cask_packages).dependent(:delete_all) }
  it { should have_many(:packages).through(:cask_packages) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:raw_url) }

  describe "#path" do
    it "returns path" do
      cask = create(:cask, url: 'https://github.com/username/.emacs.d/blob/53da80c63c467fac27d79e8c9c8653c81d4bb0a1/Cask')
      expect(cask.path).to eq '.emacs.d/Cask'
    end
  end
end

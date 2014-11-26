require 'rails_helper'

RSpec.describe Cask, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:packages).through(:cask_packages) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:raw_url) }
end

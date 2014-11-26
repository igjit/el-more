require 'rails_helper'

RSpec.describe Package, :type => :model do
  it { should have_many(:casks).through(:cask_packages) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:repo_type) }
end

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:casks) }
  it { should validate_presence_of(:login) }
end

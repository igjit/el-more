require 'stats'

describe Stats do
  describe "roundrobin" do
    it "returns a Enumerator" do
      expect(Stats.roundrobin([1])).to be_instance_of Enumerator
    end

    it "enumerates all combination of elements" do
      combinations = Stats.roundrobin([1, 2, 3, 4])
      expect(combinations.to_a).to eq [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
    end
  end

  describe "jaccard_index" do
    context "empty set(s)" do
      it { expect(Stats.jaccard_index([], [])).to be 0.0 }
      it { expect(Stats.jaccard_index([1, 2, 3], [])).to be 0.0 }
      it { expect(Stats.jaccard_index([], [1, 2, 3])).to be 0.0 }
    end

    context "disjoint sets" do
      it { expect(Stats.jaccard_index([1, 2, 3], [4, 5, 6])).to be 0.0 }
      it { expect(Stats.jaccard_index([1, 3, 5], [2, 4, 6])).to be 0.0 }
    end

    context "intersecting sets" do
      it { expect(Stats.jaccard_index([1, 2, 3], [1, 2, 4])).to be (2.0 / 4.0) }
      it { expect(Stats.jaccard_index([1, 2, 3], [1, 4, 5])).to be (1.0 / 5.0) }
      it { expect(Stats.jaccard_index([1, 2, 3], [2, 3])).to be (2.0 / 3.0) }
      it { expect(Stats.jaccard_index([1, 2, 3], [3])).to be (1.0 / 3.0) }
    end

    context "equivalent sets" do
      it { expect(Stats.jaccard_index([1, 2, 3], [1, 2, 3])).to be 1.0 }
      it { expect(Stats.jaccard_index([1, 2, 3], [3, 1, 2])).to be 1.0 }
    end
  end
end

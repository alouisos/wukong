require 'spec_helper'

describe "Reducers" do
  describe :group do
    include_context "reducers"
    it_behaves_like 'a processor', :named => :group

    let(:grouped_strings)        { [['apple', 2], ['banana', 1], ['cookie', 1]]  }
    let(:grouped_nums_from_json) { [[nil, 2], [1, 1], [5, 1], [10, 1], [100, 1]] }
    let(:grouped_nums_from_tsv)  { [[nil, 2], ['1', 1], ['5', 1], ['10', 1], ['100', 1]] }
    it "will group single values" do
      processor(:group).given(*strings.sort).should emit(*grouped_strings)
    end
    it "can group from within a JSON hash" do
      proc = processor(:group, by: 'data.n').given(*json_sorted_n).should emit(*grouped_nums_from_json)
    end
    it "can group from within a TSV row" do
      proc = processor(:group, by: '3').given(*tsv_sorted).should emit(*grouped_nums_from_tsv)
    end
  end
end

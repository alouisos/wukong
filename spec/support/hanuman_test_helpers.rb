require 'gorillib/utils/capture_output'

shared_context 'hanuman', :helpers => true do
  let(:test_stage){           Hanuman::Stage.new(:name => :testy) }

  let :example_graph do
    Hanuman::Graph.new(:name => :scraper) do
      action(:listener) << resource(:scrape_requests) << resource(:more_requests)
      action(:parser).input(:listener)
      action(:models).input(:parser)
    end
  end

end

shared_examples_for 'it can be linked into' do
  let(:mock_slot){ mock('mock slot') }
  before do
    mock_dataflow.stub(:connect).with(mock_slot, subject).and_return([mock_slot, subject])
    subject.write_attribute(:owner, mock_dataflow)
  end

  context '#<<' do
    it 'delegates to from' do
      subject.should_receive(:from).with(mock_slot)
      subject << mock_slot
    end
    it 'returns the stage itself, for chaining' do
      (subject << mock_slot).should == subject
    end
  end

  context '#from' do
    it 'asks its owner to register an edge from self into given stage' do
      mock_dataflow.should_receive(:connect).with(mock_slot, subject)
      subject.from mock_slot
    end
    it 'returns the stage itself, for chaining' do
      subject.from(mock_slot).should == subject
    end
  end

  context 'set_output' do
    it 'returns the actual receivoutg slot' do
      subject.set_output(mock_stage).should equal(subject)
    end
    it 'sets the output attribute' do
      subject.should_receive(:write_attribute).with(:output, mock_stage)
      subject.set_output(mock_stage)
    end
  end
end

shared_examples_for 'it can be linked from' do
  let(:mock_slot){ mock('mock slot') }
  before do
    mock_dataflow.stub(:connect).with(subject, mock_slot).and_return([subject, mock_slot])
    subject.write_attribute(:owner, mock_dataflow)
  end

  context '#>' do
    it 'asks its owner to register an edge into self from given stage' do
      mock_dataflow.should_receive(:connect).with(subject, mock_slot)
      subject.into mock_slot
    end
    it 'returns the output stage' do
      (subject > mock_slot).should == mock_slot
    end
  end

  context '#into' do
    it 'asks its owner to register an edge into self from given stage' do
      mock_dataflow.should_receive(:connect).with(subject, mock_slot)
      subject.into mock_slot
    end
    it 'returns the stage itself, for chaining' do
      subject.into(mock_slot).should == subject
    end
  end

  context 'set_input' do
    it 'returns the actual receiving slot' do
      subject.set_input(mock_stage).should equal(subject)
    end
    it 'sets the input attribute' do
      subject.should_receive(:write_attribute).with(:input, mock_stage)
      subject.set_input(mock_stage)
    end
  end
end

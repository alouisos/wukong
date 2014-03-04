module Hanuman

  # class Graph < Action
  #   collection :stages, Hanuman::Stage, :doc => 'the sequence of stages on this graph', :key_method => :name
  #   field      :edges,  Hash,           :doc => 'connections among all stages on the graph', :default => {}
  #   include Hanuman::IsOwnInputSlot
  #   include Hanuman::IsOwnOutputSlot

  class StageCollection < Gorillib::ModelCollection
    include Gorillib::Collection::CommonAttrs
    self.item_type = Hanuman::Stage

    # the graph that owns this collection
    attr_reader :owner

    def initialize(owner, options={})
      super(options)
      @owner = owner
      @common_attrs = common_attrs.merge(owner: owner)
    end

    def label_for(stage)
      ll = clxn.key(stage) || "#{stage.stage_type}_#{size+1}".to_sym
      stage.write_attribute(:name, ll) unless stage.name?
      ll
    end

  end

  class Graph < Stage
    magic      :name,    Symbol,               position: 0, doc: 'name of this stage'
    field      :stages,  Gorillib::Collection, doc: 'the sequence of stages on this graph',
      default: ->{ StageCollection.new(self) }
    field      :edges,   Gorillib::Collection, doc: 'connections among all stages on the graph', default: ->{ Gorillib::Collection.new } # Hash.new

    alias_method :wire, :receive!

    #
    # Construct stages
    #

    # create a stage with params and attrs (+ possible block)
    # get the object representing a stage (+ possible block)
    # replace a stage with a new stage at the given label

    def stage(label, attrs={}, &block)
      needs_label = (not stages.include?(label))
      stage = stages.update_or_add(label, attrs, &block)
      if needs_label
        as(label, stage)
      end
      stage
    end

    def as(label, stage)
      define_singleton_method(label){ stage }
      stage
    end

    # alias for get_stage
    def [](label) stages.fetch(label.to_sym) ; end

    def lookup(ref)
      ref.is_a?(Symbol) ? self[ref] : ref
    end

    #
    # Labelled stages
    #

    def subgraph(name, &block)
      stage(name, name: name, _type: Hanuman::Graph, &block)
    end

    def chain(label, &block)
      stage(name, name: name, _type: Wukong::Chain, &block)
    end

    def action(label, &block)
      stage(name, name: name, _type: Hanuman::Action, &block)
    end

    def product(label, &block)
      stage(name, name: name, _type: Hanuman::Product, &block)
    end

    #
    # Connections among stages
    #

    #
    # * look up the targets (resolving labels to stages, etc)
    #
    def connect(from_stage, into_stage)
      from_stage = lookup(from_stage)
      into_stage = lookup(into_stage)

      actual_from = from_stage.set_sink(into_stage)
      actual_into = into_stage.set_source(from_stage)

      edges[ [actual_from.graph_id, actual_into.graph_id] ] = { from: actual_from, into: actual_into }

      [from_stage, into_stage]
    end

    #
    # Control flow
    #

    def setup
      source_stages .each{|stage| stage.setup}
      process_stages.each{|stage| stage.setup}
      sink_stages   .each{|stage| stage.setup}
    end

    def stop
      source_stages .each{|stage| stage.stop}
      process_stages.each{|stage| stage.stop}
      sink_stages   .each{|stage| stage.stop}
    end

    def source_stages()  []     ; end
    def process_stages() stages ; end
    def sink_stages()    []     ; end

    def to_inspectable
      super.tap{|attrs| attrs[:edges] = [attrs[:edges].length] if attrs[:edges] }
    end
  end
end

module Hanuman
  Graph.class_eval do
    include Slottable
  end
end

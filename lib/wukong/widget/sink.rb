module Wukong
  class Sink < Wukong::Processor

    class NullSink < Wukong::Sink
      def process(record)
        true # do nothing
      end
    end

    # Write all lines to given file
    class IO < Wukong::Sink
      def process(record)
        file.puts(record)
      end
    end

    class FileSink < Wukong::Sink::IO
      field :filename, Pathname, :doc => "Filename to write"
      attr_reader :file

      def self.make(workflow, filename, stage_name=nil, attrs={})
        super(workflow, attrs.merge(:filename => filename, :name => stage_name))
      end

      def setup
        super
        filename.dirname.mkpath
        @file = File.open(filename, "w")
      end

      def stop
        @file.close if @file
      end

      register_processor
    end

    # Writes all lines to $stdout
    class Stdout < Wukong::Sink::IO
      def file() $stdout ; end
      register_processor
    end

    # Writes all lines to $stderr
    class Stderr < Wukong::Sink::IO
      def file() $stderr ; end
      register_processor
    end

    class ArraySink < Wukong::Sink
      field :records, Array, :default => [], :writer => :protected

      def process(record)
        self.records << record
      end
    end
  end
end

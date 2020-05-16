module Tradeit
  module CLI
    class Command

      attr_reader :input, :output

      def initialize(options = {})
        @options = options
        self.output = $stdout
        self.input  = $stdin
        @arguments ||= []
      end

      def execute
        run(*@arguments)
      end

      def terminal
        @terminal ||= HighLine.new(input, output)
      end

      def say(data, format = nil, style = nil)
        terminal.say format(data, format, style)
      end

      def output=(io)
        @terminal = nil
        @output = io
      end

      def input=(io)
        @terminal = nil
        @input = io
      end
    end
  end
end

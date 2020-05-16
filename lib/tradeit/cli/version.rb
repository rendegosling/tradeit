require 'tradeit/cli'
require 'tradeit/version'

require 'highline'

module Tradeit
  module CLI
    class Version < Command
      def run
        say Tradeit::VERSION
      end
    end
  end
end

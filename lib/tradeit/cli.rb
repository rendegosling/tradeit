
module Tradeit
  module CLI
    extend self

    def run(*args)
      args, opts = preparse(args)
      puts "args -> #{args}"
    end

    def preparse(unparsed, args = [], opts = {})
      case unparsed
      when Hash  then opts.merge! unparsed
      when Array then unparsed.each { |e| preparse(e, args, opts) }
      else args << unparsed.to_s
      end
      [args, opts]
    end
  end
end

module Tradeit
  module CLI

    autoload :Version, 'tradeit/cli/version'
    autoload :Command, 'tradeit/cli/command'

    extend self

    def run(*args)
      args, opts = preparse(args)
      name = args.shift unless args.empty?
      command = command(name).new(opts)
      command.execute
    end

     def preparse(unparsed, args = [], opts = {})
      case unparsed
      when Hash  then opts.merge! unparsed
      when Array then unparsed.each { |e| preparse(e, args, opts) }
      else args << unparsed.to_s
      end
      [args, opts]
    end

    def command(name)
      const_name = command_name(name)
      constant   = CLI.const_get(const_name) if const_name =~ /^[A-Z][A-Za-z]+$/ && const_defined?(const_name)
      if command?(constant)
        constant
      else
        warn "unknown command #{name}"
        exit 1
      end
    end

    def command_name(name)
      case name
      when nil, '-h', '-?'
        'Help'
      when '-v'
        'Version'
      when /^--/
        command_name(name[2..-1])
      else
        name.split('-').map(&:capitalize).join
      end
    end

    def command?(constant)
      constant.is_a?(Class)
    end
  end
end

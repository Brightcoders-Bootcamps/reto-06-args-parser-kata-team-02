# frozen_string_literal: true

require_relative 'schema'
require_relative 'verify_args'

# This class parse arguments to match the schema and print results
class ArgsParser
  def initialize
    @schema = Schema.new
    @verify = VerifyArgs.new(self)
  end

  def start(arguments)
    elements = @schema.unpack_values(arguments)
    if elements.empty? || elements.class == String
      puts elements
      return
    end
    elements.each { |arg| @verify.verify_arg_value(arg[1], arg[2], arg[3]) }
  end

  def retrieve_result(method, type, value)
    return "#{method}:  true\n" if type == TrueClass
    return "#{method}:  #{value}" if value

    "#{method}: Must contain a value"
  end
end

statement = ARGV
parser = ArgsParser.new
parser.start(statement)

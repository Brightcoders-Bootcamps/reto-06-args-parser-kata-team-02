# frozen_string_literal: true

require_relative 'schema'

# This class parse arguments to match the schema and print results
class ArgsParser
  def initialize
    @schema = Schema.new
  end

  def start(arguments)
    elements = @schema.unpack_values(arguments)
    if elements.empty?
      puts 'Invalid argument'
      return
    end
    elements.each { |arg| VerifyArgs.verify_arg_value(arg[1], arg[2], arg[3]) }
  end

  def retrieve_result(method, type, value)
    return "#{method}:  true\n" if type == TrueClass
    return "#{method}:  #{value}" if value

    "#{method}: Must contain a value"
  end
end

print 'Ingresa argumentos: '
statement = gets.split(' ')
parser = ArgsParser.new
parser.start(statement)

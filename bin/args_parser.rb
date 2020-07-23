# frozen_string_literal: true

require_relative 'schema'

# This class verify that the arguments match the schema
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
    elements.each { |arg| display_result(arg[1], arg[2], arg[3]) }
  end

  def display_result(method, type, value = nil)
    return "INV ARG TYPE: #{value.class}, expencted #{type}" if value && invalid_type?(type, value)

    print("#{method}: ", trueclass?(type) ? 'true' : value.to_s, "\n")
  end

  def invalid_type?(type, value)
    type != value&.class
  end

  def trueclass?(arg)
    arg == TrueClass
  end
end

print 'Ingresa argumentos: '
statement = gets.split(' ')
parser = ArgsParser.new
parser.start(statement)

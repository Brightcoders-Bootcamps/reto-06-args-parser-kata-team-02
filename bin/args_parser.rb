# frozen_string_literal: true

require_relative 'schema'

# This class verify that the arguments match the schema
class ArgsParser
  def initialize(statement)
    @arguments = statement
    @schema = Schema.new
  end

  def start
    @arguments.each_with_index do |arg, index|
      next unless arg.start_with?('-')
      unless @schema.valid_schema[arg]
        print "Bandera #{arg} no valida"
        return
      end
      verify_arg(arg, index + 1)
    end
  end

  def verify_arg(arg, next_index)
    next_arg = @arguments[next_index]
    return unless next_arg
    type = get_type(next_arg)
    expected = @schema.valid_schema[arg]
    if valid_arg?(arg, type) 
      print "#{expected.first}: ", flag?(next_arg) ? 'true' : next_arg.to_s, "\n"
    else
      puts "Error Type: flag #{arg} should be type #{expected.last}, #{type} given."
    end
  end

  def get_type(next_arg)
    return TrueClass if flag?(next_arg)
    return Integer if next_arg.to_i != 0
    String
  end

  def valid_arg?(arg, type)
    true if @schema.valid_schema[arg].last == type
  end

  def flag?(arg)
    arg.start_with?('-')
  end
end

print 'Ingresa argumentos: '
statement = gets.split(' ')
parser = ArgsParser.new(statement)
parser.start

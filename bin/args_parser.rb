# frozen_string_literal: true

require_relative 'schema'

# This class verify that the arguments match the schema
class ArgsParser
  def initialize(statement)
    @arguments = statement
    @schema = Schema.new
  end

  def start
    @arguments.each_with_index do |arg, idx|
      next unless arg.start_with?('-')

      print 'Argumento no valido' unless VALID[arg]
      retrieve_value(VALID[arg].first, idx + 1)
    end
  end

  def retrieve_value(arg_value, idx)
    current_argument = @arguments[idx]
    return unless current_argument

    @schema.check_type(arg_value, current_argument)

    puts flag?(idx) ? "#{arg_value} : true" : "#{arg_value} : #{current_argument}"
  end

  def flag?(idx)
    @arguments[idx].start_with?('-')
  end
end

print 'Ingresa argumentos: '
statement = gets.split(' ')
parser = ArgsParser.new(statement)
parser.start

# frozen_string_literal: true

# This class verify that the arguments match the schema
class ArgsParser
  VALID = {"port" => "-p", "loggin" => "-l", "directory" => "-d"}

  def start
    print "Ingrese argumentos: "
    args = gets().split(" ")
    parser(args)
  end

  def parser(args)
    elem = []
    args.each do |arg|
      if arg.start_with?('-')
        raise "This paramter is invalid: #{arg}" unless check_valid?(arg)
        elem.append(arg)
      end
      execute_method(elem.append(arg))
    end
  end

  def check_valid?(arg)
    VALID.value?(arg)
  end

  def execute_method(elems)
    self.public_send(VALID.key(elems.first), elems.last)
  end

  def port(port)
    puts "Running on port #{port}"
  end
end

parser = ArgsParser.new
parser.start


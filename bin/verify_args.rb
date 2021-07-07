# frozen_string_literal: true

# This class verify arguments
class VerifyArgs
  def initialize(parser)
    @parser = parser
  end

  def verify_arg_value(method, type, value = nil)
    if value && type != value&.class
      puts "INV ARG TYPE: #{value.class}, expencted #{type}"
      return
    end
    puts @parser.retrieve_result(method, type, value)
  end
end

# frozen_string_literal: true

# This class verify arguments
class VerifyArgs
  def self.verify_arg_value(method, type, value = nil)
    if value && type != value&.class
      puts "INV ARG TYPE: #{value.class}, expencted #{type}"
      return
    end
    puts retrieve_result(method, type, value)
  end
end

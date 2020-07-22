# frozen_string_literal: true

VALID = { '-p' => ['port', Integer],
          '-l' => ['logging', TrueClass],
          '-d' => ['directory', String],
          '-s' => ['server', String],
          '-m' => ['make_directory', String],
          '-a' => ['make_array', String] }.freeze

# This is Schema class
class Schema
  def check_type(flag, value)
    valid = VALID[flag]
    type = valid.last
    if type == value.class
      public_send(valid.first)
    else
      print "Error Type: flag #{flag} should be type #{type}"
    end
  end

  def port
    puts 'port'
  end

  def logging
    puts 'logging'
  end

  def directory
    puts 'directory'
  end

  def server
    puts 'server'
  end

  def make_directory
    puts 'make_directory'
  end

  def make_array
    puts 'make_array'
  end
end

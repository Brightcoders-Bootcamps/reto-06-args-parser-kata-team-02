# frozen_string_literal: true

# This is class allow specify the number and types of flags and values the program expects.
class Schema
  attr_reader :valid_schema

  def initialize()
    @valid_schema = { '-p' => ['port', Integer],
    '-l' => ['logging', TrueClass],
    '-d' => ['directory', String],
    '-s' => ['server', String],
    '-m' => ['make_directory', String],
    '-a' => ['make_array', String] }
  end
end

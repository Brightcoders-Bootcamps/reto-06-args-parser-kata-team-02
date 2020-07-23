# frozen_string_literal: true

# This is class allow specify the number and types of flags and values the program expects.
class Schema
  attr_reader :valid_schema

  def initialize
    @valid_schema = { '-p' => ['port', Integer],
                      '-l' => ['logging', TrueClass],
                      '-d' => ['directory', String],
                      '-s' => ['server', String],
                      '-m' => ['make_directory', String],
                      '-a' => ['make_array', String] }
  end

  def unpack_values(values)
    prev_flag = false
    final = []
    values.each do |val|
      break if !flag?(val) && !prev_flag

      if flag?(val) && @valid_schema[val]
        final.push(@valid_schema[val].unshift(val))
        prev_flag = true
      elsif prev_flag
        val = val.to_i if final.last.last == Integer
        final.last.append(val)
        prev_flag = false
      end
    end
    final
  end

  def flag?(arg)
    arg.start_with?('-')
  end
end

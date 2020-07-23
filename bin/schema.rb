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
    @final = []
    @prev_flag = false
  end

  def unpack_values(values)
    values.each do |val|
      is_flag = val.start_with?('-')
      break if !is_flag && !@prev_flag

      curret_valid_value = @valid_schema[val]
      store_finale(is_flag, val, curret_valid_value)
    end
    @final
  end

  def store_finale(is_flag, val, curret_valid_value)
    class_value = @final.last
    if is_flag && curret_valid_value
      @final.push(curret_valid_value.unshift(val))
      @prev_flag = true
    elsif @prev_flag
      val = val.to_i if class_value.last == Integer
      class_value.append(val)
      @prev_flag = false
    end
  end
end

class GroupArray
  def initialize(array)
    @array = array
  end

  def divide_smooth(number)
    division = array.size.div number
    modulo = array.size % number
    box = division + [modulo, 1].min # あまりも収める

    groups = array.in_groups(box)
    groups.map.with_index { |group, index|
      index.odd? ? group.reverse : group
    }.transpose.map(&:compact)
  end

  private

  attr_reader :array
end

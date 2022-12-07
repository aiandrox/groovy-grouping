class GroupArray
  def initialize(array)
    @array = array
  end

  def divide_smooth(group_count)
    raise ArgumentError, '配列の長さより指定グループ数が多いです' if array.size < group_count

    groups = array.in_groups_of(group_count)
    groups.transpose.map(&:compact)
  end

  private

  attr_reader :array
end

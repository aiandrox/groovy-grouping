class GroupAssigner
  def initialize(event)
    @event = event
  end

  def assign_groups
    if @event.criteria.present?
      attendances = @event.attendances.includes(:criterion_statuses).to_a

      groups = assign_attendances_to_groups(attendances, @event.group_count, @event.criteria)

      max_group_size = groups.max_by(&:size).size
      min_group_size = groups.min_by(&:size).size

      # グループの人数の最大人数と最少人数の差が2人以上の場合は再帰
      if max_group_size - min_group_size >= 2
        assign_groups
      else
        groups
      end
    else
      @event.attendances.shuffle.in_groups(@event.group_count, false)
    end
  end

  private

  def assign_attendances_to_groups(attendances, group_count, criteria)
    attendances.shuffle!

    groups = Array.new(group_count) { [] }
    sorted_criteria = criteria.sort_by(&:priority).reverse

    sorted_criteria.each do |criterion|
      criterion_attendances = attendances.select do |attendance|
        attendance.criterion_statuses.any? { |status| status.criterion_id == criterion.id }
      end

      assign_criterion_attendances(groups, criterion_attendances)
      attendances -= criterion_attendances
    end

    assign_remaining_attendances(groups, attendances)
    groups
  end

  def assign_criterion_attendances(groups, criterion_attendances)
    criterion_attendances.each do |attendance|
      target_group = select_target_group(groups, attendance)
      target_group << attendance
    end
  end

  def assign_remaining_attendances(groups, attendances)
    attendances.each do |attendance|
      target_group = select_target_group(groups, attendance)
      target_group << attendance
    end
  end

  def select_target_group(groups, attendance)
    min_group_size = groups.min_by(&:size).size
    groups.select { |group| group.size <= min_group_size + 1 }.min_by do |group|
      group.count { |group_attendance| attendance.criterion_status_ids == group_attendance.criterion_status_ids }
    end
  end
end

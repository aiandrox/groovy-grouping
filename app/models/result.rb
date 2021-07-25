class Result < ApplicationRecord
  def self.group(event)
    if event.criteria.present?
      event.attendances.joins(attendance_statuses: :criterion_status).group_by(&:criterion_status_ids)
    else
      event.attendances.suffle
    end
  end
end

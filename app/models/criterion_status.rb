# == Schema Information
#
# Table name: criterion_statuses
#
#  id           :bigint           not null, primary key
#  name         :string(255)      not null
#  remarks      :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  criterion_id :bigint           not null
#
# Indexes
#
#  index_criterion_statuses_on_criterion_id  (criterion_id)
#
# Foreign Keys
#
#  fk_rails_...  (criterion_id => criteria.id)
#
class CriterionStatus < ApplicationRecord
  belongs_to :criterion

  validates :name, presence: true, length: { maximum: 50 }
  validates :remarks, presence: true, length: { maximum: 200 }
end

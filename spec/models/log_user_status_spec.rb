# == Schema Information
#
# Table name: log_user_statuses
#
#  id              :bigint           not null, primary key
#  status_name     :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  group_user_id   :bigint           not null
#  log_criteria_id :bigint           not null
#
# Indexes
#
#  index_log_user_statuses_on_group_user_id    (group_user_id)
#  index_log_user_statuses_on_log_criteria_id  (log_criteria_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_user_id => group_users.id)
#  fk_rails_...  (log_criteria_id => log_criteria.id)
#
require 'rails_helper'

RSpec.describe LogUserStatus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

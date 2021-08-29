# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  edit_uuid   :string(255)      not null
#  group_count :integer
#  name        :string(255)      not null
#  ref_uuid    :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  team_id     :bigint           not null
#
# Indexes
#
#  index_events_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
FactoryBot.define do
  factory :event do
    name { FFaker::Lorem.word }
    ref_uuid { SecureRandom.uuid }
    edit_uuid { SecureRandom.uuid }
    team
  end
end

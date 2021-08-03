# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  edit_uuid  :string(255)      not null
#  name       :string(255)      not null
#  ref_uuid   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :team do
    name { FFaker::Lorem.word }
    ref_uuid { SecureRandom.uuid }
    edit_uuid { SecureRandom.uuid }
  end
end

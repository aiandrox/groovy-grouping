# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  edit_uuid  :string(255)      not null
#  name       :string(255)      default("未設定"), not null
#  ref_uuid   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :team do
    name { "MyString" }
    ref_uuid { "MyString" }
    edit_uuid { "MyString" }
  end
end

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
require 'rails_helper'

RSpec.describe Team, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: results
#
#  id          :bigint           not null, primary key
#  group_count :integer          not null
#  uuid        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :bigint           not null
#
# Indexes
#
#  index_results_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
require 'rails_helper'

RSpec.describe Result, type: :model do
  describe '.group' do
    subject { Result.group(event) }
    let!(:team) { create(:team) }
    let!(:event) { create(:event, team: team, group_count: 2) }
    let!(:user_1) { create(:user, team: team) }
    let!(:user_2) { create(:user, team: team) }
    let!(:user_3) { create(:user, team: team) }
    let!(:user_4) { create(:user, team: team) }
    let!(:user_5) { create(:user, team: team) }
    let!(:attendance_1) { create(:attendance, event: event, user: user_1) }
    let!(:attendance_2) { create(:attendance, event: event, user: user_2) }
    let!(:attendance_3) { create(:attendance, event: event, user: user_3) }
    let!(:attendance_4) { create(:attendance, event: event, user: user_4) }
    let!(:attendance_5) { create(:attendance, event: event, user: user_5) }

    context '条件がないとき' do
      it '結果レコードを作成する' do
        expect { subject }.to change(Result, :count).by(1)
                          .and change(Group, :count).by(2)
                          .and change(GroupUser, :count).by(5)
      end

      it '均等に2チームに分ける（2人グループ・3人グループ）' do
        subject
        result = Result.last
        expect(result.groups.size).to eq 2
        expect(result.group_count).to eq 2
        expect(result.groups.first.users.size).to eq 3
        expect(result.groups.last.users.size).to eq 2
      end
    end

    context '条件があるとき' do
      context '5人・条件2つ（2:3）' do
        let!(:criterion) { create(:criterion, event: event) }
        let!(:criterion_status_1) { create(:criterion_status, criterion: criterion) }
        let!(:criterion_status_2) { create(:criterion_status, criterion: criterion) }
        let!(:attendance_status_1) { create(:attendance_status, attendance: attendance_1, criterion_status: criterion_status_1) }
        let!(:attendance_status_2) { create(:attendance_status, attendance: attendance_2, criterion_status: criterion_status_1) }
        let!(:attendance_status_3) { create(:attendance_status, attendance: attendance_3, criterion_status: criterion_status_2) }
        let!(:attendance_status_4) { create(:attendance_status, attendance: attendance_4, criterion_status: criterion_status_2) }
        let!(:attendance_status_5) { create(:attendance_status, attendance: attendance_5, criterion_status: criterion_status_2) }

        it '結果レコードを作成する' do
          expect { subject }.to change(Result, :count).by(1)
                            .and change(Group, :count).by(2)
                            .and change(GroupUser, :count).by(5)
                            .and change(LogCriterion, :count).by(1)
                            .and change(LogUserStatus, :count).by(5)
        end

        it '均等に2チームに分ける（2人グループ・3人グループ）' do
          subject
          result = Result.last
          expect(result.groups.size).to eq 2
          expect(result.group_count).to eq 2
          group_1 = result.groups.first
          group_2 = result.groups.last
          expect(group_1.users.size).to eq 3
          expect(group_2.users.size).to eq 2
        end

        it '条件で均等に分ける' do
          subject
          result = Result.last
          group_1 = result.groups.first
          group_2 = result.groups.last
          group_1_attendance_statuses = AttendanceStatus.joins(:attendance).where(attendances: { user_id: group_1.users.ids })
          group_2_attendance_statuses = AttendanceStatus.joins(:attendance).where(attendances: { user_id: group_2.users.ids })
          expect(group_1_attendance_statuses.pluck(:criterion_status_id)).to include(criterion_status_1.id, criterion_status_2.id)
          expect(group_2_attendance_statuses.pluck(:criterion_status_id)).to include(criterion_status_1.id, criterion_status_2.id)
        end
      end

      context '7人・条件2つ（2:2:3）' do
        let!(:criterion) { create(:criterion, event: event) }
        let!(:criterion_status_1) { create(:criterion_status, criterion: criterion) }
        let!(:criterion_status_2) { create(:criterion_status, criterion: criterion) }
        let!(:attendance_status_1) { create(:attendance_status, attendance: attendance_1, criterion_status: criterion_status_1) }
        let!(:attendance_status_2) { create(:attendance_status, attendance: attendance_2, criterion_status: criterion_status_1) }
        let!(:attendance_status_3) { create(:attendance_status, attendance: attendance_3, criterion_status: criterion_status_2) }
        let!(:attendance_status_4) { create(:attendance_status, attendance: attendance_4, criterion_status: criterion_status_2) }
        let!(:attendance_status_5) { create(:attendance_status, attendance: attendance_5, criterion_status: criterion_status_2) }

        let!(:attendance_6) { create(:attendance, event: event) }
        let!(:attendance_7) { create(:attendance, event: event) }
        let!(:attendance_status_6) { create(:attendance_status, attendance: attendance_6, criterion_status: criterion_status_1) }
        let!(:attendance_status_7) { create(:attendance_status, attendance: attendance_7, criterion_status: criterion_status_2) }

        it '均等に3チームに分ける（2人グループ・3人グループ）' do
          subject
          result = Result.last
          expect(result.groups.size).to eq 3
          expect(result.group_count).to eq 3
          group_1 = result.groups.first
          group_2 = result.groups.second
          group_3 = result.groups.last
          expect(group_1.users.size).to eq 3
          expect(group_2.users.size).to eq 2
          expect(group_2.users.size).to eq 2
        end

        it '条件で均等に分ける' do
          subject
          result = Result.last
          group_1 = result.groups.first
          group_2 = result.groups.second
          group_3 = result.groups.last
          group_1_attendance_statuses = AttendanceStatus.joins(:attendance).where(attendances: { user_id: group_1.users.ids })
          group_2_attendance_statuses = AttendanceStatus.joins(:attendance).where(attendances: { user_id: group_2.users.ids })
          group_3_attendance_statuses = AttendanceStatus.joins(:attendance).where(attendances: { user_id: group_3.users.ids })
          expect(group_1_attendance_statuses.pluck(:criterion_status_id)).to include(criterion_status_1.id, criterion_status_2.id)
          expect(group_2_attendance_statuses.pluck(:criterion_status_id)).to include(criterion_status_1.id, criterion_status_2.id)
          expect(group_3_attendance_statuses.pluck(:criterion_status_id)).to include(criterion_status_1.id, criterion_status_2.id)
        end
      end
    end
  end
end

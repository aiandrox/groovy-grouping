RSpec.describe GroupArray, type: :model do
  describe '#divide_smooth' do
    subject { described_class.new(array).divide_smooth(number) }

    context '配列の数より指定グループ数の方が多い場合' do
      let!(:array) { [1] }
      let!(:number) { 2 }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context '割り切れる場合（長さ6の配列を2グループにならす）' do
      let!(:array) { [1, 2, 3, 4, 5, 6] }
      let!(:number) { 3 }

      it { is_expected.to eq([[1, 4], [2, 5], [3, 6]]) }
    end

    context '割り切れない場合（長さ7の配列を3グループにならす）' do
      let!(:array) { [1, 2, 3, 4, 5, 6, 7] }
      let!(:number) { 3 }

      it { is_expected.to eq([[1, 4, 7], [2, 5], [3, 6]]) }
    end
  end
end

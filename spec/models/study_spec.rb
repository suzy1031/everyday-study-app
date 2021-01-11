require 'rails_helper'

RSpec.describe Study, type: :model do
  describe 'model validation' do
    let(:study) { FactoryBot.create(:study) }

    context 'success create' do
      it 'create data' do
        user = User.create(email: 'test@test.com', password: 'password')
        user.studies.create(time: '0.5', total: '1')
        expect{ study }.to change{ Study.count }.by(1)
      end

      it 'is with a valid params' do
        study.valid?
        expect(study).to be_valid
      end

      it 'check float type' do
        study = build(:study)
        expect(study.time).to be_a_kind_of(Float)
        expect(study.total).to be_a_kind_of(Float)
      end
    end

    context 'failure create' do
      it 'is null with a time' do
        expect(FactoryBot.build(:study, time: nil, total: '1')).to_not be_valid
      end

      it 'is null with a total' do
        expect(FactoryBot.build(:study, time: '0.5', total: nil)).to_not be_valid
      end

      it 'is more than 24 hour with a time' do
        expect(FactoryBot.build(:study, time: '25', total: '25')).to_not be_valid
      end
    end
  end
end
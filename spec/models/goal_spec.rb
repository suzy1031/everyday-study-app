require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'model validation' do
    let(:goal) { FactoryBot.create(:goal) }

    context 'success create' do
      it 'create data' do
        user = User.create(email: 'test@test.com', password: 'password')
        user.goals.create(target_time: '10')
        expect{ goal }.to change{ Goal.count }.by(1)
      end

      it 'is with a valid params' do
        goal.valid?
        expect(goal).to be_valid
      end

      it 'checks float type' do
        goal = build(:goal)
        expect(goal.target_time).to be_a_kind_of(Float)
      end
    end

    context 'failure create' do
      it 'is null with a target_time' do
        expect(FactoryBot.build(:goal, target_time: '')).to_not be_valid
      end

      it 'is more than 168 hour with a target_time' do
        expect(FactoryBot.build(:goal, target_time: '169')).to_not be_valid
      end

      it 'is less than 0.1 hour with a target_time' do
        expect(FactoryBot.build(:goal, target_time: '0.09')).to_not be_valid
      end

      it 'is more than 5 length with a target_time' do
        expect(FactoryBot.build(:goal, target_time: '168.999')).to_not be_valid
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Study, type: :model do
  describe 'Model Validation' do
    context 'Success Create' do
      it 'Valid params' do
        study = build(:study)
        study.valid?
        expect(study).to be_valid
      end

      it 'Check Float Type' do
        study = build(:study)
        expect(study.time).to be_a_kind_of(Float)
        expect(study.total).to be_a_kind_of(Float)
      end
    end
  end
end
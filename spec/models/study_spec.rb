require 'rails_helper'

RSpec.describe Study, type: :model do
  describe 'model validation' do
    context 'success create' do
      it 'valid params' do
        study = build(:study)
        study.valid?
        expect(study).to be_valid
      end

      it 'check float type' do
        study = build(:study)
        expect(study.time).to be_a_kind_of(Float)
        expect(study.total).to be_a_kind_of(Float)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Study, type: :model do
  describe "validate presence" do
    context "timeを指定しているとき" do
      it "レコードが作成される" do
        study = build(:study)
        study.valid?
        expect(study).to be_valid
      end
    end
  end
end
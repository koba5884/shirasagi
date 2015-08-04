require 'spec_helper'

RSpec.describe Schedule::Category, type: :model, dbscope: :example do
  describe 'name uniqueness validation' do
    before do
      @category = build(:schedule_category, name: create(:schedule_category).name)
      @category.valid?
    end

    it { expect(@category).to be_invalid }
    it { expect(@category.errors[:name].size).to eq 1 }
    it { expect(@category.errors[:name].first).to match I18n.t('errors.messages.taken') }
  end
end

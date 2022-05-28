require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to have_many(:users).through(:bookings) }
  end

  describe 'validations' do
    it do
      is_expected.to validate_presence_of(:name)
      is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(100)
      is_expected.to validate_uniqueness_of(:name).case_insensitive
      is_expected.to validate_presence_of(:capacity)
      is_expected.to validate_numericality_of(:capacity).is_greater_than(0)
    end
  end
end

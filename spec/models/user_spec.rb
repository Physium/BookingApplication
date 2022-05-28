require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to have_many(:rooms).through(:bookings) }
  end

  describe 'validations' do
    context 'basic validations' do
      it do
        is_expected.to validate_presence_of(:first_name)
        is_expected.to validate_presence_of(:last_name)
        is_expected.to validate_presence_of(:username)
        is_expected.to validate_uniqueness_of(:username).case_insensitive
        is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(25)
        is_expected.to validate_presence_of(:email)
        is_expected.to validate_length_of(:email).is_at_most(105)
        is_expected.to allow_value('test@gmail.com').for(:email)
        is_expected.to_not allow_value('invalidemail').for(:email)
        is_expected.to have_secure_password(:password)
      end
    end
  end
end

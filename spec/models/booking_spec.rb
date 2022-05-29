require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'associations' do
    before do
      allow_any_instance_of(described_class).to receive(:check_time).and_return(nil)
      allow_any_instance_of(described_class).to receive(:check_date).and_return(nil)
    end

    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'scope' do
    describe '.bookings_between' do
      let(:user) { create(:user) }
      let(:room) { create(:room) }
      let(:booking) { create(:booking, user: user, room: room) }
      let(:booking2) { create(:booking) }
      let(:start_time) { booking.start_time + 10.minutes }
      let(:end_time) { start_time + 1.hour }

      subject { described_class.bookings_between(start_time, end_time) }

      it { expect(subject).to contain_exactly(booking, booking2) }

      context 'when bookings are not within range' do
        let(:start_time) { end_time - 1.hour }
        let(:end_time) { Date.today.end_of_day - 1.hour }

        it { expect(subject).to be_empty }
      end
    end

    describe '.room_bookings_between' do
      let(:user) { create(:user) }
      let(:room) { create(:room) }
      let(:booking) { create(:booking, user: user, room: room) }
      let(:booking2) { create(:booking, room: room, start_time: booking2_start_time, end_time: booking2_end_time) }
      let(:booking2_start_time) { booking.end_time + 10.minutes }
      let(:booking2_end_time) { booking2_start_time + 1.hour }
      let(:start_time) { booking.start_time + 10.minutes }
      let(:end_time) { start_time + 2.hour }

      subject { described_class.room_bookings_between(room, start_time, end_time) }

      it do
        expect(subject).to contain_exactly(booking, booking2)
      end

      context 'when bookings are not within range' do
        let(:start_time) { end_time - 1.hour }
        let(:end_time) { Date.today.end_of_day - 1.hour }

        it { expect(subject.last).to be_nil }
      end
    end
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:booking) { create(:booking, user: user, room: room) }
    let(:start_time) { end_time - 1.hour }
    let(:end_time) { Date.today.end_of_day - 1.hour }
    let(:new_booking) { build(:booking, user: user, room: room, start_time: start_time, end_time: end_time) }

    subject { new_booking }

    it { expect(subject.valid?).to be_truthy }

    context 'basic validations' do
      before do
        allow_any_instance_of(described_class).to receive(:check_time).and_return(nil)
        allow_any_instance_of(described_class).to receive(:check_date).and_return(nil)
      end

      it do
        is_expected.to validate_presence_of(:start_time)
        is_expected.to validate_presence_of(:end_time)
        is_expected.to validate_presence_of(:title)
      end
    end

    describe '.check_time_slot' do
      context 'when new booking overlap with other room booking' do
        let(:start_time) { booking.start_time + 10.minutes }
        let(:end_time) { start_time + 1.hour }

        it do
          expect(subject.valid?).to be_falsey
          expect(subject.errors[:start_time].first).to eq('Selected time has other bookings in place')
          expect(subject.errors[:end_time].first).to eq('Selected time has other bookings in place')
        end
      end
    end

    describe '.check_time' do
      context 'when new booking start time is greater than end time' do
        let(:start_time) { Date.today.end_of_day }

        it do
          expect(subject.valid?).to be_falsey
          expect(subject.errors[:start_time].first).to eq('Start time is greater than or equal to end time')
        end
      end
    end

    describe '.check_date' do
      context 'when booking date is more than a day' do
        let(:start_time) { Date.today.beginning_of_day + 1.day }
        let(:end_time) { start_time + 1.week }

        it do
          expect(subject.valid?).to be_falsey
          expect(subject.errors[:start_time].first).to eq('Keep bookings to a day only!')
          expect(subject.errors[:end_time].first).to eq('Keep bookings to a day only!')
        end
      end
    end
  end

  describe '.overlap_meeting?' do
    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:booking) { create(:booking, user: user, room: room) }

    let(:start_time) { end_time - 1.hour }
    let(:end_time) { Date.today.end_of_day - 1.hour }
    let(:new_booking) { build(:booking, user: user, room: room, start_time: start_time, end_time: end_time) }

    subject { new_booking }

    it { expect(new_booking.no_overlap_bookings?).to be_truthy }

    context 'when new booking time overlap with existing bookings' do
      let(:start_time) { booking.start_time + 10.minutes }
      let(:end_time) { start_time + 1.hour }

      it { expect(new_booking.no_overlap_bookings?).to be_falsey }
    end
  end
end

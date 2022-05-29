require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe '#search' do
    let(:rooms) { create_list(:room, 10) }
    let(:room) { rooms.first }
    let!(:booking) { create(:booking, user: user, room: room) }
    let(:start_time) { Date.today.beginning_of_day.to_s }
    let(:end_time) { (Date.today.beginning_of_day + 1.hour).to_s }
    let(:params) do
      {
        start_time: DateTime.parse(start_time).to_s,
        end_time: DateTime.parse(end_time).to_s
      }
    end

    subject { post :search, params: params }

    it do
      subject

      available_rooms = Room.all - [room]
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(available_rooms.to_json)
    end
  end

  describe '#create' do
  end
end

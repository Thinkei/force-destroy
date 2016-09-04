require 'spec_helper'

describe Force::Destroy do
  it 'has a version number' do
    expect(Force::Destroy::VERSION).not_to be nil
  end

  describe 'force_destroy!' do
    let!(:user) { create(:user) }
    let!(:another_user) { create(:user) }
    let!(:profile) { create(:profile, user: user) }
    let!(:tickets) { create_list(:ticket, 2, user: user) }
    let(:data_before_destroy) {
      {
        user: 2,
        profile: 1,
        ticket: 2,
        seat: 2,
        room: 2
      }
    }

    context 'User' do
      let(:data_after_destroy) {
        {
          user: 1,
          profile: 0,
          ticket: 0,
          seat: 2,
          room: 2
        }
      }

      it 'delete the user itself and its associations' do
        data_before_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
        user.force_destroy!
        data_after_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
      end
    end

    context 'Profile' do
      let(:data_after_destroy) {
        {
          user: 1,
          profile: 0,
          ticket: 0,
          seat: 2,
          room: 2
        }
      }

      it 'delete the profile itself and its associations' do
        data_before_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
        profile.destroy
        expect(Profile.count).not_to eq 0
        profile.force_destroy!
        data_after_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
      end
    end

    context 'Ticket' do
      let(:data_after_destroy) {
        {
          user: 2,
          profile: 1,
          ticket: 0,
          seat: 2,
          room: 2
        }
      }

      it 'delete the ticket itself and its associations' do
        data_before_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
        user.tickets.force_destroy_all!
        data_after_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
      end
    end

    context 'Seat' do
      let(:data_after_destroy) {
        {
          user: 2,
          profile: 1,
          ticket: 0,
          seat: 0,
          room: 2
        }
      }

      it 'delete the ticket itself and its associations' do
        data_before_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
        Seat.force_destroy_all!
        data_after_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
      end
    end

    context 'Room' do
      let(:data_after_destroy) {
        {
          user: 2,
          profile: 1,
          ticket: 0,
          seat: 0,
          room: 0
        }
      }

      it 'delete the ticket itself and its associations' do
        data_before_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
        Room.force_destroy_all!
        data_after_destroy.each do |name, total|
          expect(name.to_s.camelize.constantize.count).to eq total
        end
      end
    end
  end
end

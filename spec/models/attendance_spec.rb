require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:test_user) { User.create(name: 'atenais') }
  let(:test_event) do
    Event.create(title: 'brunch',
                 description: 'Delicius food',
                 date: '2021-04-15 00:00:00',
                 local: '',
                 creator_id: test_user.id)
  end
  let(:subject) do
    described_class.new(attendee_id: test_user.id,
                        attended_event_id: test_event.id)
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:attendee) }
    it { should belong_to(:attended_event) }
  end
end

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:test_user) { User.create(name: 'atenais') }
  let(:subject) do
    described_class.new(title: 'brunch',
                        description: 'Delicius food',
                        date: '2021-04-15 00:00:00',
                        local: '',
                        creator_id: test_user.id)
  end

  describe 'validations' do
    it 'is valid with all attrs' do
      expect(subject).to be_valid
    end

    it 'is not valid without creator id' do
      subject.creator_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with title length < 5' do
      subject.title = 'part'
      expect(subject).to_not be_valid
    end

    it 'is not valid with missing date' do
      subject.date = nil
      expect(subject).to_not be_valid
    end
  end
end

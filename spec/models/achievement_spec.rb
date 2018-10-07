require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
  end

  describe 'instance methods' do
    let(:user) { FactoryBot.create(:user, email: 'test@test.com') }
    let(:achievement) { FactoryBot.create(:public_achievement, title: 'New Title', user: user) }
    let(:achievement1) { FactoryBot.create(:public_achievement, user: user) }
    let(:achievement2) { FactoryBot.create(:public_achievement, title: 'Jajca', user: user) }


    it 'has silly title method' do
      expect(achievement.silly_title).to eq('New Title by test@test.com')
    end

    it 'fetches achievements which title starts on provided letter' do
      expect(Achievement.by_letter('J')).to eq([achievement2])
    end

    context 'more users' do
      let(:dupek) { FactoryBot.create(:user, email: 'zupek@test.com') }
      let(:achievement3) { FactoryBot.create(:public_achievement, title: 'Jajowanie', user: dupek) }
      it 'sorts achievement by user email' do

        expect(Achievement.by_letter('J')).to eq([achievement2, achievement3])
      end
    end
  end
end

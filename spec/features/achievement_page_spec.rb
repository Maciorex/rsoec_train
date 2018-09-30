require 'rails_helper'

feature 'achievement page' do
  let(:user) { FactoryBot.create(:user) }
  scenario 'achievement public page' do
    achievement = FactoryBot.create(:achievement, title: 'Yeah', user: user)
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Yeah')
  end

  scenario 'render description' do
    achievement = FactoryBot.create(:achievement, description: 'Mordo', user: user)
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Mordo')
  end
end

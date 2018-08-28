require 'rails_helper'

feature 'achievement page' do
  scenario 'achievement public page' do
    achievement = FactoryBot.create(:achievement, title: 'Yeah')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Yeah')
  end

  scenario 'render description' do
    achievement = FactoryBot.create(:achievement, description: 'Mordo')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Mordo')
  end
end
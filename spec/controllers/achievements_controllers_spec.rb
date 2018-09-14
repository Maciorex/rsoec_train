require 'rails_helper'

describe AchievementsController do
  describe 'GET index' do
    it 'renders index template' do

    end
  end

  describe 'GET new' do
    it 'renders a new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns Achievement to @achievement' do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe 'GET show' do
    let(:achievement) { FactoryBot.create(:public_achievement) }

    it 'renders show template' do
      get :show, params: { id: achievement.id }
      expect(response).to render_template(:show)
    end

    it 'assigns requested achievement to @achievement' do
      get :show, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'POST create' do
    context 'valid data' do
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement) }
      it 'redirects to achievement/show' do
        post :create, params: { achievement: valid_data }
        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
      end
      it 'creates new achievement in db' do
        expect {
          post :create, params: { achievement: valid_data }
        }.to change(Achievement, :count).by(1)
      end
    end

    context 'invalid data' do
      let(:invalid_data) { FactoryBot.attributes_for(:public_achievement, title: '') }
      it 'renders new template' do
        post :create, params: { achievement: invalid_data }
        expect(response).to render_template(:new)
      end
      it 'does not create new achievement' do
        expect {
          post :create, params: { achievement: invalid_data }
        }.not_to change(Achievement, :count)
      end
    end
  end
end

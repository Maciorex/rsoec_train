require 'rails_helper'

describe AchievementsController do

  describe 'guest user' do
    describe 'GET index' do
      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns only public achievements' do
        public_achievement = FactoryBot.create(:public_achievement)
        private_achievement = FactoryBot.create(:private_achievement)
        get :index
        expect(assigns(:achievements)).to match_array([public_achievement])
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

    describe 'GET new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'redirects to login page' do
        post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET edit' do
      it 'redirects to login page' do
        get :edit, params: { id: FactoryBot.create(:public_achievement).id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT update' do
      let(:achievement) { FactoryBot.create(:public_achievement) }
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: 'New Title') }
      it 'redirects to login page' do
        put :update, params: { id: achievement.id, achievement: valid_data }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirects to login page' do
        delete :destroy, params: { id: FactoryBot.create(:public_achievement).id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET edit' do
    let(:achievement) { FactoryBot.create(:public_achievement) }
    it 'renders edit template' do
      get :edit, params: { id: achievement.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns requested achievement to template' do
      get :edit, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'PUT update' do
    let(:achievement) { FactoryBot.create(:public_achievement) }
    context 'valid data' do
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: 'New Title') }

      it 'redirects to achievement#show' do
        put :update, params: { id: achievement.id, achievement: valid_data }
        expect(response).to redirect_to(achievement)
      end

      it 'updates achievement in database' do
        put :update, params: { id: achievement.id, achievement: valid_data }
        achievement.reload
        expect(achievement.title).to eq('New Title')
      end
    end

    context 'invalid data' do
      let(:invalid_data) { FactoryBot.attributes_for(:public_achievement, title: '', description: 'new') }

      it 'renders edit template' do
        put :update, params: { id: achievement.id, achievement: invalid_data }
        expect(response).to render_template(:edit)
      end

      it 'does not updates database' do
        put :update, params: { id: achievement.id, achievement: invalid_data }
        achievement.reload
        expect(achievement.title).to eq('title')
      end
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

  describe 'DELETE destroy' do
    let(:achievement) { FactoryBot.create(:public_achievement) }

    it 'redirects to index' do
      delete :destroy, params: { id: achievement.id }
      expect(response).to redirect_to(achievements_path)
    end

    it 'destroys record from database' do
      delete :destroy, params: { id: achievement.id }
      expect(Achievement.exists?(achievement.id)).to be_falsy
    end
  end
end

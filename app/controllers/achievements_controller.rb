class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  before_action :check_owner, only: [:edit, :update, :destroy]
  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user = current_user
    if @achievement.save
      flash[:notice] = 'Achievement has been created'
      redirect_to @achievement
    else
      flash[:notice] = 'Something wrong'
      render :new
    end
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def edit; end

  def update
    if @achievement.update(achievement_params)
      flash[:notice] = 'Achievement has been updated'
      redirect_to @achievement
    else
      flash[:notice] = 'Something wrong'
      render :edit
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :cover_image,
                                        :featured, :privacy)
  end

  def check_owner
    @achievement = Achievement.find(params[:id])
    redirect_to achievements_path if current_user != @achievement.user
  end
end

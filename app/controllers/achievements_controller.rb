class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
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

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update(achievement_params)
      flash[:notice] = 'Achievement has been updated'
      redirect_to @achievement
    else
      flash[:notice] = 'Something wrong'
      render :edit
    end
  end

  def destroy
    Achievement.destroy(params[:id])
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :cover_image,
                                        :featured, :privacy)
  end
end

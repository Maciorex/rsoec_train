class AchievementsController < ApplicationController
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

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :cover_image,
                                        :featured, :privacy)
  end
end

class CreateAchievement
  attr_accessor :achievement

  def initialize(params, user)
   @user = user
    @params = params
  end

  def create
  end

  def created?
  end
end

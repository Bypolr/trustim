class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      remember @user
      flash[:success] = "Welcome to Trust!"
      redirect_to @user
  	else
  		render :new
  	end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end

  private
  
  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end
end

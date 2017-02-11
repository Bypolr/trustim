class UsersController < ApplicationController
  before_action :check_logged_in, only: [:edit, :update, :index, :destroy]
  before_action :check_correct_user, only: [:edit, :update]
  before_action :check_admin_user, only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find_by(username: params[:id])
    unless @user.activated?
      redirect_to root_url
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_mail
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
  	else
  		render :new
  	end
  end

  def edit
    @user = User.find_by(username: params[:id])
  end

  def update
    @user = User.find_by(username: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.username}'s profile updated successfully."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find_by(username: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private

  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end

    # Before filters

    # Confirms a logged-in user.
    def check_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def check_correct_user
      @user = User.find_by(username: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def check_admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @pagy, @users = pagy(User.all, items: 10)
  end

  def show
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
    # Handle a successful update.
      flash[:success] = "Successfully updated user."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "Delete fail!"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "You must be logged in."
      store_location
      redirect_to login_url
    end
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = "you cannot edit this account."
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end

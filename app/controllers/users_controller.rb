class UsersController < ApplicationController
  skip_before_action :must_logged_in, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    @user = User.new(params.permit(:name, :mail, :password, :password_confirmation))
    if @user.save
      flash[:notice] = t(:user_created)
      redirect_to '/'
    else
      render action: :new
    end
  end
  def edit
    @user = @current_user
  end
  def update
    @user = @current_user
    @user.name = params[:name]
    @user.mail = params[:mail]
    if params[:password]
      @user.password = params[:password]
      @user.password = params[:password_confirmation]
    end
    if @user.save
      flash[:notice] = t(:user_updated)
      redirect_to '/'
    else
      render action: :edit
    end
  end
end

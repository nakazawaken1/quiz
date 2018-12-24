class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(params.permit(:name, :mail, :password, :password_confirmation))
    if @user.save
      redirect_to "/"
    else
      render("users/new")
    end
  end
end

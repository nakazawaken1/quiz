class SessionsController < ApplicationController
  skip_before_action :must_logged_in, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    @user = User.find_by(mail: params[:mail])
    if @user and @user.authenticate(params[:password])
      token = SecureRandom.urlsafe_base64
      @user.token = User.encrypt(token)
      @user.save
      cookies.permanent[:user_token] = token
      redirect_to '/'
    else
      @user = User.new
      flash[:notice] = t(:login_failed)
      render action: :new
    end
  end
  def destroy
    cookies.delete :user_token
    cookies.delete :question_id
    redirect_to '/'
  end
end

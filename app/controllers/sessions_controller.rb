class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by_email(params[:email])

    if !@user
      flash[:notice_email_errors] = ['No user with the specified email found']

      if params[:password].empty?
        flash[:notice_password_errors] = ['Password can not be blank']
      end

      render :new
    else
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_in_path
  end
end

class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  
  def new
    unless session[:user_id].nil?
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      #@user.errors = "hello"
      flash[:notice] = "Invalid Username or Password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to '/'
  end
  #use this as a login page
  def page_requires_login

  end
end

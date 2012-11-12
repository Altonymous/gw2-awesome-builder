class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.order(:email)

    respond_with @users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

    respond_with @user
  end

  def edit
    @user = User.find(params[:id])

    respond_with @user
  end

  def create
    @user = User.create(params[:user])

    respond_with @user
  end

  def update
    @user = User.find(params[:id])
    if current_user.is_administrator?
      @user.update_attributes(params[:user])
    else
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      @user.update_with_password(params[:user])
      sign_in(@user, bypass: true)
    end

    respond_with @user
  end

  def destroy
    @user = User.destroy(params[:id])

    respond_with @user
  end
end

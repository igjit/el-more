class UsersController < ApplicationController
  PER = 10

  def index
    @users = User.page(params[:page]).per(PER).using_cask_for_configuration.order(followers: :desc)
  end

  def show
  end
end

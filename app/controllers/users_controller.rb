class UsersController < ApplicationController
  PER = 10

  def index
    @users = User.page(params[:page]).per(PER).using_cask_for_configuration.order(followers: :desc)
  end

  def show
    @user = User.find(params[:id])
    @casks = @user.casks.where(configuration: true)
    @packages = Package.uniq.joins(:casks).where('casks.id' => @casks).order(:name)
  end
end

class HomeController < ApplicationController
  def index
    @packages = Package.page(params[:page]).per(10).popular
  end
end

class HomeController < ApplicationController
  def index
    @packages = Package.page(params[:page]).per(10).popular
    @new_packages = Package.added_after(1.month.ago).limit(10)
  end
end

class PackagesController < ApplicationController
  PER = 20
  WORD_LIMIT = 5

  def index
    @packages = Package.page(params[:page]).per(PER).popular

    if params[:q]
      words = tokenize(params[:q]).uniq.take(WORD_LIMIT)
      @packages = @packages.search(contains_all(words)).result
    end
  end

  def show
    @package = Package.find(params[:id])
    @similar_packages = @package.similar_packages(limit: 20)
    @users = @package.casks.select('users.*').uniq.joins(:user)
      .order('users.followers DESC').to_a
  end

  private

  def tokenize(str)
    str.scan /\w+/
  end

  def contains_all(values)
    alist = values.map.with_index do |x, i|
      [i.to_s, { m: 'or', name_cont: x, description_cont: x }]
    end

    { m: 'and', g: Hash[alist] }
  end
end

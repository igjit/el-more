class PackagesController < ApplicationController
  WORD_LIMIT = 5

  def index
    @packages = Package.popular

    if params[:q]
      words = tokenize(params[:q]).uniq.take(WORD_LIMIT)
      @packages = @packages.search(contains_all(words)).result
    end
  end

  def show
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

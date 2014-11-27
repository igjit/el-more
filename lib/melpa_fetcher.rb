require 'open-uri'
require 'json'

class MelpaFetcher
  def initialize
    @recipes = JSON(read_text('http://melpa.milkbox.net/recipes.json'))
    @archive = JSON(read_text('http://melpa.milkbox.net/archive.json'))
  end

  def packages
    Enumerator.new do |yielder|
      package_names.each do |name|
        yielder << create_package(name)
      end
    end
  end

  def package_names
    @recipes.keys
  end

  def create_package(name)
    recipe = @recipes[name]
    package = Package.new
    package.name = name
    package.repo_type = recipe['fetcher']
    package.url = source_url(name, recipe)
    package.description = @archive[name]['desc'] rescue nil
    package
  end

  def source_url(name, recipe)
    if recipe['fetcher'] == 'github'
      (recipe['repo'].match('/') ? "https://github.com/" : "https://gist.github.com/") +
        recipe['repo']
    elsif recipe['fetcher'] == "wiki" && !recipe['files']
      "http://www.emacswiki.org/emacs/" + name + ".el"
    elsif recipe['url']
      url_match = lambda do |re, prefix|
        m = recipe['url'].match(re)
        prefix + m[1] if m
      end
      url_match.call(/(bitbucket\.org\/[^\/]+\/[^\/\?]+)/, "https://") ||
        url_match.call(/(gitorious\.org\/[^\/]+\/[^.]+)/, "https://") ||
        url_match.call(/\Alp:(.*)/, "https://launchpad.net/") ||
        url_match.call(/\A(https?:\/\/code\.google\.com\/p\/[^\/]+\/)/, '') ||
        url_match.call(/\A(https?:\/\/[^.]+\.googlecode\.com\/)/, '')
    else
      nil
    end
  end

  def read_text(url)
    open(url) { |f| f.read }
  end

  def inspect
    "#<#{self.class}>"
  end
end

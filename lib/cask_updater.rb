require 'github_code_search'

module CaskUpdater
  module_function

  DEFAULT_QUERY = "filename:cask depends-on size:<100000"
  INTERVAL = 10

  def update(page_count, search: nil)
    search ||= GithubCodeSearch.new(DEFAULT_QUERY)

    (1..page_count).each do |page|
      save_search_result!(search, page)

      sleep INTERVAL unless page == page_count
    end
  end

  def save_search_result!(search, page)
    search.result(page).each do |item|
      if item[:code][:url].end_with? '/Cask' # Save Cask file only
        save_item! item
      end
    end
  end

  def save_item!(item)
    user = User.find_or_create_by!(url: item[:user][:url]) do |user|
      user.attributes = item[:user]
    end

    url = item[:code][:url]
    unless Cask.exists?(url: url)
      outdated_casks = Cask.where("url LIKE ?", url.sub(%r{/blob/\S{40}/}, '/blob/%/'))
      outdated_casks.destroy_all

      cask = Cask.create!(item[:code])
      user.casks << cask
    end
  end
end

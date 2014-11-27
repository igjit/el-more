require 'nokogiri'
require 'open-uri'

class GithubCodeSearch
  SEARCH_URL = 'https://github.com/search'

  def initialize(query, sort: nil, order: :desc)
    @params = { q: query, s: sort, o: order, type: 'Code' }
  end

  def result(page)
    params = @params.merge(p: page)
    uri = URI(SEARCH_URL)
    uri.query = params.to_param

    doc = Nokogiri::HTML(open uri)

    doc.css("div.code-list-item").map do |item|
      user_path = item.css('a').attribute('href').value
      user = user_path.split('/').last
      code_path = item.css('p.title a').last.attribute('href').value
      code_raw_path = code_path.sub(%r{(\A/[^/]+/[^/]+/)blob}, '\1raw')

      { user: { login: user, url: (uri + user_path).to_s },
        code: { url: (uri + code_path).to_s, raw_url: (uri + code_raw_path).to_s } }
    end
  end
end
